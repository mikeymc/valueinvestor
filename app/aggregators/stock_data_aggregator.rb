class StockDataAggregator
  def aggregate
    destroy_stocks
    initialize_stocks
    # aggregate_yahoo_data
    # aggregate_market_watch_data
  end

  def aggregate_market_watch_data
    MarketWatchDataAggregator.new.aggregate
  end

  private

  def destroy_stocks
    Stock.destroy_all
  end

  def initialize_stocks
    initializer = ListInitializer.new
    initializer.load_nasdaq_list
    initializer.load_nyse_list
  end

  def aggregate_yahoo_data
    YahooDataAggregator.new.aggregate
  end
end
