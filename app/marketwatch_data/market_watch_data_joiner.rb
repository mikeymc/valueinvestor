class MarketWatchDataJoiner
  def join(symbol, data)
    stock = Stock.find_by_symbol(symbol)
    stock.market_watch_data = MarketWatchData.new(data)
    stock.save!
  end
end
