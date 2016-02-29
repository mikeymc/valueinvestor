require 'rails_helper'

RSpec.describe YahooKeyStatisticsDataFetcher do
  it 'returns data for a stock from the MarketWatch analyst estimates page' do
    apple_data = File.read('aapl_key_statistics.html')

    WebMock
      .stub_request(:get, 'http://finance.yahoo.com/q/ks?s=ABC')
      .to_return(:status => 200, :body => apple_data, :headers => {:content_type => 'text/html'})

    data = YahooKeyStatisticsDataFetcher.new.fetch('ABC')
    expect(data[:enterprise_value]).to eq(561930000000)
    expect(data[:profit_margin]).to eq(22.87)
    expect(data[:operating_margin]).to eq(30.28)
    expect(data[:return_on_assets]).to eq(16.02)
    expect(data[:return_on_equity]).to eq(42.71)
    expect(data[:beta]).to eq(1.35)
  end

  it 'skips data that does not return a 200' do
    WebMock
      .stub_request(:get, 'http://finance.yahoo.com/q/ks?s=ABC')
      .to_return(:status => 500)

    data = YahooKeyStatisticsDataFetcher.new.fetch('ABC')
    expect(data).to be_nil
  end
end
