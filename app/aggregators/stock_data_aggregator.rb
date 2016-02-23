class StockDataAggregator
  def aggregate
    destroy_stocks
    initialize_stocks
    yahoo_stock_data = fetch_yahoo_stock_data
    join_yahoo_stock_data(yahoo_stock_data)
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

  def fetch_yahoo_stock_data
    fetcher = YahooStockDataFetcher.new
    tickers = Stock.list_all_symbols
    tickers.map! { |ticker| ticker.strip }
    yahoo_stock_data = []
    while !tickers.empty? do
      yahoo_stock_data << fetcher.fetch_stock_data(tickers.shift(200))
    end
    yahoo_stock_data
  end

  def join_yahoo_stock_data(data)
    StockDataJoiner.new.join(data.flatten)
  end

  def fetch_market_watch_data
    market_watch_data_fetcher = MarketWatchDataFetcher.new
    Stock.list_all_symbols.each do |symbol|
      data = market_watch_data_fetcher.fetch(symbol)
      MarketWatchDataJoiner.new.join(symbol, data)
    end
  end
end
