require 'byebug'

class StockDataJoiner
  def join(yahoo_stock_data)
    yahoo_stock_data.each do |yahoo_stock|
      File.open("stocks_to_join.txt", 'a') {|f| f.write("#{yahoo_stock}\n") }
      stock = Stock.find_by_symbol(yahoo_stock[:symbol])
      stock.current_eps = yahoo_stock[:current_eps]
      stock.dividends_per_share = yahoo_stock[:dividends_per_share]
      stock.day_high_price = yahoo_stock[:day_high_price]
      stock.day_low_price = yahoo_stock[:day_low_price]
      stock.book_value = yahoo_stock[:book_value]
      stock.price_to_book_ratio = yahoo_stock[:price_to_book_ratio]
      stock.price_to_earnings_ratio = yahoo_stock[:price_to_earnings_ratio]
      stock.year_low_price = yahoo_stock[:year_low_price]
      stock.year_high_price = yahoo_stock[:year_high_price]
      stock.save!
    end
  end
end
