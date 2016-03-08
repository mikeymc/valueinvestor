require 'rails_helper'

RSpec.describe StockDataAggregator do
  fake_response = "\"Tiffany & Co. Common Stock\",\"TIF\",\"NYQ\",3.78,1.60,61.91,60.43,22.25,2.73\n\"Apple Computer Inc.\",\"AAPL\",\"NCM\",-0.190,N/A,N/A,N/A,0.000,N/A"

  before(:each) do
    WebMock
      .stub_request(:get, /download\.finance\.yahoo\.com/)
      .to_return(:status => 200, :body => fake_response, :headers => {})
  end

  it 'deletes everything and reconstructs Nasdaq and NYSE stocks' do
    expect(Stock).to receive(:destroy_all).and_call_original
    expect_any_instance_of(ListInitializer).to receive(:load_nyse_list).and_wrap_original do
      create(:stock, name: 'Another NYSE Stock Name', symbol: 'TIF')
    end
    expect_any_instance_of(ListInitializer).to receive(:load_nasdaq_list).and_wrap_original do
      create(:stock, name: 'Another Nasdaq Stock Name', symbol: 'AAPL')
    end
    StockDataAggregator.new.aggregate
  end
end
