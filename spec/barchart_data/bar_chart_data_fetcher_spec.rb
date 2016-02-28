require 'rails_helper'

RSpec.describe BarChartDataFetcher do
  it 'returns data for a stock from the MarketWatch analyst estimates page' do
    apple_data = File.read('aapl_barchart_estimate.html')

    WebMock
      .stub_request(:get, 'http://www.barchart.com/opinions/stocks/ABC')
      .to_return(:status => 200, :body => apple_data, :headers => {:content_type => 'text/html'})

    data = BarChartDataFetcher.new.fetch('ABC')
    expect(data[:average_recommendation]).to eq('40% Sell')
  end

  it 'skips data that does not return a 200' do
    WebMock
      .stub_request(:get, 'http://www.barchart.com/opinions/stocks/ABC')
      .to_return(:status => 500)

    data = BarChartDataFetcher.new.fetch('ABC')
    expect(data).to be_nil
  end
end
