require 'rails_helper'

RSpec.describe StockDataAggregator do
  fake_response = "\"Tiffany & Co. Common Stock\",\"TIF\",\"NYQ\",3.78,1.60,61.91,60.43,22.25,2.73\n\"Response Genetics, Inc.\",\"RGDX\",\"NCM\",-0.190,N/A,N/A,N/A,0.000,N/A"

  before(:each) do
    create(:stock, name: 'Tiffany & Co. Common Stock', index: 'NYQ', symbol: 'TIF')
    create(:stock, name: 'Response Genetics, Inc.', index: 'NCM', symbol: 'RGDX')
    WebMock
      .stub_request(:get, /download\.finance\.yahoo\.com/)
      .to_return(:status => 200, :body => fake_response, :headers => {})
  end

  it 'deletes the stocks db' do
    expect(Stock).to receive(:delete_all)

    aggregator = StockDataAggregator.new
    aggregator.aggregate
  end

  it 'reconstructs the Nasdaq and NYSE stock lists' do
    expect(Stock).to receive(:delete_all)
    expect_any_instance_of(ListInitializer).to receive(:initialize_nyse_list)
    expect_any_instance_of(ListInitializer).to receive(:initialize_nasdaq_list)

    aggregator = StockDataAggregator.new
    aggregator.aggregate
  end

  it 'fetches the yahoo data for all the stocks' do
    expect(Stock).to receive(:delete_all)
    expect_any_instance_of(YahooStockDataFetcher).to receive(:fetch_stock_data).exactly(32).times.and_call_original

    aggregator = StockDataAggregator.new
    aggregator.aggregate
  end

  it 'merges the yahoo data in' do
    expect(Stock).to receive(:delete_all)
    aggregator = StockDataAggregator.new
    aggregator.aggregate

    expect(Stock.find_by_symbol('RGDX').book_value).not_to be_nil
  end
end
