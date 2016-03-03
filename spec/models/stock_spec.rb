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

  context 'scopes' do
    describe 'yield_above' do
      it 'returns stocks with yields greater than or equal to the input' do
        create(:stock, symbol: 'ABC', name: 'ABC Corp', yahoo_data: create(:yahoo_data, dividend_yield: 0.1))
        create(:stock, symbol: 'DEF', name: 'DEF Corp', yahoo_data: create(:yahoo_data, dividend_yield: 1.1))
        create(:stock, symbol: 'GHI', name: 'GHI Corp', yahoo_data: create(:yahoo_data, dividend_yield: 2.1))
        create(:stock, symbol: 'JKL', name: 'JKL Corp', yahoo_data: create(:yahoo_data, dividend_yield: 3.1))

        high_yield_stocks = Stock.includes(:yahoo_data).references(:yahoo_data).yield_above(1.1)

        expect(high_yield_stocks.size).to eq(3)
      end
    end

    describe 'price_to_earnings_below' do
      it 'returns stocks with P/E ratios lower than or equal to the input' do
        create(:stock, symbol: 'ABC', name: 'ABC Corp', yahoo_data: create(:yahoo_data, price_to_earnings_ratio: 14.1))
        create(:stock, symbol: 'DEF', name: 'DEF Corp', yahoo_data: create(:yahoo_data, price_to_earnings_ratio: 10.1))
        create(:stock, symbol: 'GHI', name: 'GHI Corp', yahoo_data: create(:yahoo_data, price_to_earnings_ratio: 32.1))
        create(:stock, symbol: 'JKL', name: 'JKL Corp', yahoo_data: create(:yahoo_data, price_to_earnings_ratio: 3.1))

        high_yield_stocks = Stock.includes(:yahoo_data).references(:yahoo_data).price_to_earnings_below(10.1)

        expect(high_yield_stocks.size).to eq(2)
      end
    end

    describe 'profit_margin_at_least' do
      it 'returns stocks with profit margins greater than or equal to the input' do
        create(:stock, symbol: 'ABC', name: 'ABC Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, profit_margin: 14.1))
        create(:stock, symbol: 'DEF', name: 'DEF Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, profit_margin: 10.1))
        create(:stock, symbol: 'GHI', name: 'GHI Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, profit_margin: 32.1))
        create(:stock, symbol: 'JKL', name: 'JKL Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, profit_margin: 3.1))
        create(:stock, symbol: 'MNO', name: 'MNO Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, profit_margin: -3.1))

        high_yield_stocks = Stock.includes(:yahoo_key_statistics_data).references(:yahoo_key_statistics_data).profit_margin_at_least(0)

        expect(high_yield_stocks.size).to eq(4)
      end
    end

    describe 'operating_margin_at_least' do
      it 'returns stocks with operating margins greater than or equal to the input' do
        create(:stock, symbol: 'ABC', name: 'ABC Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, operating_margin: 14.1))
        create(:stock, symbol: 'DEF', name: 'DEF Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, operating_margin: 10.1))
        create(:stock, symbol: 'GHI', name: 'GHI Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, operating_margin: 32.1))
        create(:stock, symbol: 'JKL', name: 'JKL Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, operating_margin: 3.1))
        create(:stock, symbol: 'MNO', name: 'MNO Corp', yahoo_key_statistics_data: create(:yahoo_key_statistics_data, operating_margin: -3.1))

        high_yield_stocks = Stock.includes(:yahoo_key_statistics_data).references(:yahoo_key_statistics_data).operating_margin_at_least(-2)

        expect(high_yield_stocks.size).to eq(4)
      end
    end

    describe 'one_year_year_target_growth_rate_at_least' do
      it 'returns stocks with projected growth rates greater than or equal to the input' do
        create(:stock, symbol: 'ABC', name: 'ABC Corp', yahoo_data: create(:yahoo_data, one_year_growth_expectation: 14.1))
        create(:stock, symbol: 'DEF', name: 'DEF Corp', yahoo_data: create(:yahoo_data, one_year_growth_expectation: 10.1))
        create(:stock, symbol: 'GHI', name: 'GHI Corp', yahoo_data: create(:yahoo_data, one_year_growth_expectation: 32.1))
        create(:stock, symbol: 'JKL', name: 'JKL Corp', yahoo_data: create(:yahoo_data, one_year_growth_expectation: 3.1))
        create(:stock, symbol: 'MNO', name: 'MNO Corp', yahoo_data: create(:yahoo_data, one_year_growth_expectation: -3.1))

        high_growth_stocks = Stock.includes(:yahoo_data).references(:yahoo_data).one_year_target_growth_rate_at_least(10)

        expect(high_growth_stocks.size).to eq(3)
      end
    end

    describe 'search' do
      it 'returns stocks with names that match' do
        create(:stock, symbol: 'BEST WESTERN', name: 'ABC Corp')
        create(:stock, symbol: 'WESTERN UNION', name: 'DEF Corp')
        create(:stock, symbol: 'BESTEST FRIENDS INC', name: 'GHI Corp')
        create(:stock, symbol: 'WEST NILE', name: 'JKL Corp')
        create(:stock, symbol: 'SOMETHING ELSE', name: 'MNO Corp')

        high_growth_stocks = Stock.search_by_name('WEST')

        expect(high_growth_stocks.size).to eq(3)
      end
    end
  end
end
