class StockDataAggregator
  def aggregate
    destroy_stocks
    initialize_stocks
    aggregate_yahoo_data
    fetch_market_watch_data
  end

  private

  def destroy_stocks
    Stock.destroy_all
  end

  def initialize_stocks
    initializer = ListInitializer.new
    initializer.initialize_nasdaq_list
    initializer.initialize_nyse_list
  end

  def aggregate_yahoo_data
    YahooDataAggregator.new.aggregate
  end

  def fetch_market_watch_data
    market_watch_data_fetcher = MarketWatchDataFetcher.new
    Stock.list_all_symbols.each do |symbol|
      data = market_watch_data_fetcher.fetch(symbol)
      MarketWatchDataJoiner.new.join(symbol, data)
    end
  end
end
