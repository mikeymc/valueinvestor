require 'rails_helper'

RSpec.describe Stock, :type => :model do
  describe 'create_new_stock' do
    it 'saves a stock hash into a stock object' do
      stock_hash = {
        name: 'stock-name',
        symbol: 'stock-symbol',
        index: 'stock-index',
        currentEPS: 'current-eps',
        dividends_per_share: 'stock-dividends',
        day_high_price: 'stock-day-high',
        day_low_price: 'stock-day-low',
        book_value: 'stock-book-value',
        price_to_book_ratio: 'stock-price-to-book'
      }

      Stock.create_new_stock(stock_hash)
      stock = Stock.last
      expect(stock.name).to eq('stock-name')
      expect(stock.index).to eq('stock-index')
      expect(stock.symbol).to eq('stock-symbol')
      expect(stock.currentEPS).to eq('current-eps')
      expect(stock.dividends_per_share).to eq('stock-dividends')
      expect(stock.day_high_price).to eq('stock-day-high')
      expect(stock.day_low_price).to eq('stock-day-low')
      expect(stock.book_value).to eq('stock-book-value')
      expect(stock.price_to_book_ratio).to eq('stock-price-to-book')
    end
    it 'enters any N/A as an empty string' do
      stock_hash = {
        name: 'Some Stock',
        symbol: 'ABC',
        index: 'N/A',
        currentEPS: 'N/A',
        dividends_per_share: 'N/A',
        day_high_price: 'N/A',
        day_low_price: 'N/A',
        book_value: 'N/A',
        price_to_book_ratio: 'N/A'
      }

      Stock.create_new_stock(stock_hash)
      stock = Stock.last
      expect(stock.name).to eq('Some Stock')
      expect(stock.index).to eq('')
      expect(stock.symbol).to eq('ABC')
      expect(stock.currentEPS).to eq('')
      expect(stock.dividends_per_share).to eq('')
      expect(stock.day_high_price).to eq('')
      expect(stock.day_low_price).to eq('')
      expect(stock.book_value).to eq('')
      expect(stock.price_to_book_ratio).to eq('')
    end
    it 'enters any NaN as an empty string' do
      stock_hash = {
        name: 'nan',
        symbol: 'nan',
        index: 'nan',
        currentEPS: 'nan',
        dividends_per_share: 'nan',
        day_high_price: 'nan',
        day_low_price: 'nan',
        book_value: 'nan',
        price_to_book_ratio: 'nan'
      }

      Stock.create_new_stock(stock_hash)
      stock = Stock.last
      expect(stock.name).to eq('')
      expect(stock.index).to eq('')
      expect(stock.symbol).to eq('')
      expect(stock.currentEPS).to eq('')
      expect(stock.dividends_per_share).to eq('')
      expect(stock.day_high_price).to eq('')
      expect(stock.day_low_price).to eq('')
      expect(stock.book_value).to eq('')
      expect(stock.price_to_book_ratio).to eq('')
    end
    it 'saves only stocks with names' do
      first_stock = {
        name: 'N/A',
        symbol: 'ABC',
        index: 'stock-index',
        currentEPS: 'current-eps',
        dividends_per_share: 'stock-dividends',
        day_high_price: 'stock-day-high',
        day_low_price: 'stock-day-low',
        book_value: 'stock-book-value',
        price_to_book_ratio: 'stock-price-to-book'
      }
      second_stock = {
        name: 'stock-name',
        symbol: 'DEF',
        index: 'stock-index',
        currentEPS: 'current-eps',
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
