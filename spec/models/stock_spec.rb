require 'rails_helper'

RSpec.describe Stock, :type => :model do
  describe 'create_new_stock' do
    it 'saves a stock hash into a stock object' do
      stock_hash = {
        name: 'stock-name',
        symbol: 'stock-symbol',
        exchange: 'stock-exchange',
        current_eps: '1.2',
        dividends_per_share: '2.3',
        day_high_price: '3.4',
        day_low_price: '4.5',
        book_value: '5.6',
        price_to_book_ratio: '6.7'
      }

      Stock.create_new_stock(stock_hash)
      stock = Stock.last
      expect(stock.name).to eq('stock-name')
      expect(stock.exchange).to eq('stock-exchange')
      expect(stock.symbol).to eq('stock-symbol')
      expect(stock.current_eps).to eq(1.2)
      expect(stock.dividends_per_share).to eq(2.3)
      expect(stock.day_high_price).to eq(3.4)
      expect(stock.day_low_price).to eq(4.5)
      expect(stock.book_value).to eq(5.6)
      expect(stock.price_to_book_ratio).to eq(6.7)
    end
    it 'enters any N/A as an empty string' do
      stock_hash = {
        name: 'Some Stock',
        symbol: 'ABC',
        exchange: 'N/A',
        current_eps: 'N/A',
        dividends_per_share: 'N/A',
        day_high_price: 'N/A',
        day_low_price: 'N/A',
        book_value: 'N/A',
        price_to_book_ratio: 'N/A'
      }

      Stock.create_new_stock(stock_hash)
      stock = Stock.last
      expect(stock.name).to eq('Some Stock')
      expect(stock.exchange).to eq('')
      expect(stock.symbol).to eq('ABC')
      expect(stock.current_eps).to eq(nil)
      expect(stock.dividends_per_share).to eq(nil)
      expect(stock.day_high_price).to eq(nil)
      expect(stock.day_low_price).to eq(nil)
      expect(stock.book_value).to eq(nil)
      expect(stock.price_to_book_ratio).to eq(nil)
    end
    it 'enters any NaN as an empty string' do
      stock_hash = {
        name: 'nan',
        symbol: 'nan',
        exchange: 'nan',
        current_eps: 'nan',
        dividends_per_share: 'nan',
        day_high_price: 'nan',
        day_low_price: 'nan',
        book_value: 'nan',
        price_to_book_ratio: 'nan'
      }

      Stock.create_new_stock(stock_hash)
      stock = Stock.last
      expect(stock.name).to eq('')
      expect(stock.exchange).to eq('')
      expect(stock.symbol).to eq('')
      expect(stock.current_eps).to eq(nil)
      expect(stock.dividends_per_share).to eq(nil)
      expect(stock.day_high_price).to eq(nil)
      expect(stock.day_low_price).to eq(nil)
      expect(stock.book_value).to eq(nil)
      expect(stock.price_to_book_ratio).to eq(nil)
    end
    it 'saves only stocks with names' do
      first_stock = {
        name: 'N/A',
        symbol: 'ABC',
        exchange: 'stock-exchange',
        current_eps: 'current-eps',
        dividends_per_share: 'stock-dividends',
        day_high_price: 'stock-day-high',
        day_low_price: 'stock-day-low',
        book_value: 'stock-book-value',
        price_to_book_ratio: 'stock-price-to-book'
      }
      second_stock = {
        name: 'stock-name',
        symbol: 'DEF',
        exchange: 'stock-exchange',
        current_eps: 'current-eps',
        dividends_per_share: 'stock-dividends',
        day_high_price: 'stock-day-high',
        day_low_price: 'stock-day-low',
        book_value: 'stock-book-value',
        price_to_book_ratio: 'stock-price-to-book'
      }

      Stock.create_new_stock(first_stock)
      Stock.create_new_stock(second_stock)
      expect(Stock.all.size).to eq(1)
      stock = Stock.last
      expect(stock.name).to eq('stock-name')
      expect(stock.symbol).to eq('DEF')
    end
  end
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
end
