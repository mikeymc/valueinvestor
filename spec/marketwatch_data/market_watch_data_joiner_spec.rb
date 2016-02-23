require 'rails_helper'

RSpec.describe MarketWatchDataJoiner do
  before(:each) do
    create(:stock, symbol: 'AAPL')
  end

  it 'returns data for a stock from the MarketWatch analyst estimates page' do
    data = {
      average_recommendation: 'Buy'
    }
    MarketWatchDataJoiner.new.join('AAPL', data)
    expect(Stock.find_by_symbol('AAPL').market_watch_data.average_recommendation).to eq('Buy')
  end
end
