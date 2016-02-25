class YahooDataJoiner
  def join(yahoo_stock_data)
    yahoo_stock_data.each do |yahoo_stock|
      stock = Stock.find_by_symbol(yahoo_stock[:symbol])
      stock.yahoo_data = YahooData.new
      stock.yahoo_data.current_eps = yahoo_stock[:current_eps]
      stock.yahoo_data.dividends_per_share = yahoo_stock[:dividends_per_share]
      stock.yahoo_data.day_high_price = yahoo_stock[:day_high_price]
      stock.yahoo_data.day_low_price = yahoo_stock[:day_low_price]
      stock.yahoo_data.book_value = yahoo_stock[:book_value]
      stock.yahoo_data.price_to_book_ratio = yahoo_stock[:price_to_book_ratio]
      stock.yahoo_data.price_to_earnings_ratio = yahoo_stock[:price_to_earnings_ratio]
      stock.yahoo_data.year_low_price = yahoo_stock[:year_low_price]
      stock.yahoo_data.year_high_price = yahoo_stock[:year_high_price]
      stock.yahoo_data.save!
    end
  end
end
