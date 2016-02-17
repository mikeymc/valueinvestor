class StockDataJoiner
  def join(yahoo_stock_data)
    yahoo_stock_data.each do |yahoo_stock|
      stock = Stock.find_by_symbol(yahoo_stock[:symbol])
      stock.currentEPS = yahoo_stock[:currentEPS]
      stock.dividends_per_share = yahoo_stock[:dividends_per_share]
      stock.day_high_price = yahoo_stock[:day_high_price]
      stock.day_low_price = yahoo_stock[:day_low_price]
      stock.book_value = yahoo_stock[:book_value]
      stock.price_to_book_ratio = yahoo_stock[:price_to_book_ratio]
      stock.save!
    end
  end
end