require 'rails_helper'

RSpec.describe StreetInsiderDataJoiner do
  before(:each) do
    create(:stock, symbol: 'AAPL')
  end

  it 'returns data for a stock from the MarketWatch analyst estimates page' do
    data = {
      average_recommendation: 'Buy'
    }
    StreetInsiderDataJoiner.new.join('AAPL', data)
    expect(Stock.find_by_symbol('AAPL').street_insider_data.average_recommendation).to eq('Buy')
  end

  it 'does nothing when the response is nil' do
    StreetInsiderDataJoiner.new.join('AAPL', nil)
    expect(Stock.find_by_symbol('AAPL').street_insider_data).to be_nil
  end
end
