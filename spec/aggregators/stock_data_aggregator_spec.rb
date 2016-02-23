require 'rails_helper'

RSpec.describe StockDataAggregator do
  fake_response = "\"Tiffany & Co. Common Stock\",\"TIF\",\"NYQ\",3.78,1.60,61.91,60.43,22.25,2.73\n\"Apple Computer Inc.\",\"AAPL\",\"NCM\",-0.190,N/A,N/A,N/A,0.000,N/A"

  before(:each) do
    WebMock
      .stub_request(:get, /download\.finance\.yahoo\.com/)
      .to_return(:status => 200, :body => fake_response, :headers => {})
  end

  it 'deletes everything, constructs Nasdaq and NYSE stocks, joins Yahoo finance data, and adds MarketWatch data' do
    expect(Stock).to receive(:destroy_all).and_call_original
    expect_any_instance_of(ListInitializer).to receive(:initialize_nyse_list).and_wrap_original do
      create(:stock, name: 'Another NYSE Stock Name', symbol: 'TIF')
    end
    expect_any_instance_of(ListInitializer).to receive(:initialize_nasdaq_list).and_wrap_original do
      create(:stock, name: 'Another Nasdaq Stock Name', symbol: 'AAPL')
    end
    expect_any_instance_of(YahooStockDataFetcher).to receive(:fetch_stock_data).exactly(1).times.and_call_original
    expect_any_instance_of(MarketWatchDataFetcher).to receive(:fetch).with('AAPL').and_return({average_recommendation: 'Buy'})
    expect_any_instance_of(MarketWatchDataFetcher).to receive(:fetch).with('TIF').and_return({average_recommendation: 'Hold'})
    StockDataAggregator.new.aggregate

    expect(Stock.find_by_symbol('AAPL').book_value.to_s).to match(/\d+\.\d+/)

    expect(Stock.find_by_symbol('AAPL').market_watch_data.average_recommendation).to eq('Buy')
    expect(Stock.find_by_symbol('TIF').market_watch_data.average_recommendation).to eq('Hold')
  end
end
