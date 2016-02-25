class MarketWatchDataJoiner
  def join(symbol, data)
    unless data.nil?
      stock = Stock.find_by_symbol(symbol)
      stock.market_watch_data = MarketWatchData.new(data)
      stock.market_watch_data.save!
    end
  end
end
