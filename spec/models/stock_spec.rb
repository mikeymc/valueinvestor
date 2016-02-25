require 'rails_helper'

RSpec.describe Stock, :type => :model do
  describe 'list_all_symbols' do
    it 'returns a list of all the stock symbols in the db' do
      create(:stock, name: 'ABC Corp', symbol: 'ABC')
      create(:stock, name: 'DEF Corp', symbol: 'DEF')
      create(:stock, name: 'GHI Corp', symbol: 'GHI')

      symbols = Stock.list_all_symbols
      expect(symbols.size).to eq(3)
      expect(symbols[0]).to eq('ABC')
      expect(symbols[1]).to eq('DEF')
      expect(symbols[2]).to eq('GHI')
    end
  end

  describe 'destroy' do
    it 'deletes the market watch data too' do
      create(:stock, symbol: 'AAPL', market_watch_data: create(:market_watch_data))

      expect(Stock.all.size).to eq(1)
      expect(MarketWatchData.all.size).to eq(1)
      expect(Stock.find_by_symbol('AAPL').market_watch_data.average_recommendation).to eq('Buy')

      Stock.find_by_symbol('AAPL').destroy

      expect(Stock.all.size).to eq(0)
      expect(MarketWatchData.all.size).to eq(0)
    end
  end

  describe 'destroy_all' do
    it 'deletes the market watch data too' do
      create(:stock, symbol: 'AAPL', market_watch_data: create(:market_watch_data))
      create(:stock, symbol: 'XOM', market_watch_data: create(:market_watch_data))

      expect(Stock.all.size).to eq(2)
      expect(MarketWatchData.all.size).to eq(2)

      Stock.destroy_all

      expect(Stock.all.size).to eq(0)
      expect(MarketWatchData.all.size).to eq(0)
    end
  end
end
