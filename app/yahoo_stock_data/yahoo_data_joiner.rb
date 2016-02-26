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
      stock.yahoo_data.ebitda = yahoo_stock[:ebitda]
      stock.yahoo_data.last_trade_price = yahoo_stock[:last_trade_price]
      stock.yahoo_data.market_cap = yahoo_stock[:market_cap]
      stock.yahoo_data.one_year_target_price = yahoo_stock[:one_year_target_price]
      stock.yahoo_data.fifty_day_moving_average = yahoo_stock[:fifty_day_moving_average]
      stock.yahoo_data.percent_change_from_fifty_day_moving_average = yahoo_stock[:percent_change_from_fifty_day_moving_average]
      stock.yahoo_data.two_hundred_day_moving_average = yahoo_stock[:two_hundred_day_moving_average]
      stock.yahoo_data.percent_change_from_two_hundred_day_moving_average = yahoo_stock[:percent_change_from_two_hundred_day_moving_average]
      stock.yahoo_data.save!
    end
  end
end
