require 'rails_helper'

RSpec.describe MarketWatchDataFetcher do
  it 'returns data for a stock from the MarketWatch analyst estimates page' do
    apple_data = File.read('apple_marketwatch_estimate.html')

    WebMock
      .stub_request(:get, 'http://www.marketwatch.com/investing/stock/ABC/analystestimates')
      .to_return(:status => 200, :body => apple_data, :headers => {:content_type => 'text/html'})

    data = MarketWatchDataFetcher.new.fetch('ABC')
    expect(data[:average_recommendation]).to eq('Buy')
  end

  it 'skips data that does not return a 200' do
    WebMock
      .stub_request(:get, 'http://www.marketwatch.com/investing/stock/ABC/analystestimates')
      .to_return(:status => 500)

    data = MarketWatchDataFetcher.new.fetch('ABC')
    expect(data).to be_nil
  end
end
