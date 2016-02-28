require 'rails_helper'

RSpec.describe StreetInsiderDataFetcher do
  it 'returns data for a stock from the MarketWatch analyst estimates page' do
    apple_data = File.read('aapl_street_insider_estimate.html')

    WebMock
      .stub_request(:get, 'http://www.streetinsider.com/rating_history.php?q=ABC')
      .to_return(:status => 200, :body => apple_data, :headers => {:content_type => 'text/html'})

    data = StreetInsiderDataFetcher.new.fetch('ABC')
    expect(data[:average_recommendation]).to eq('NEUTRAL')
  end

  it 'skips data that does not return a 200' do
    WebMock
      .stub_request(:get, 'http://www.streetinsider.com/rating_history.php?q=ABC')
      .to_return(:status => 500)

    data = StreetInsiderDataFetcher.new.fetch('ABC')
    expect(data).to be_nil
  end
end
