class MarketWatchDataAggregator
  def aggregate
    market_watch_data_fetcher = MarketWatchDataFetcher.new
    Stock.list_all_symbols.each do |symbol|
      data = market_watch_data_fetcher.fetch(symbol)
      MarketWatchDataJoiner.new.join(symbol, data)
    end
  end
end
