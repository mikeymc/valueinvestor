class StockDataAggregator
  def aggregate
    Stock.delete_all
    initializer = ListInitializer.new
    initializer.initialize_nasdaq_list
    initializer.initialize_nyse_list
    yahoo_stock_data_fetcher = YahooStockDataFetcher.new
    tickers = Stock.list_all_symbols
    tickers.map! { |ticker| ticker.strip }
    yahoo_stock_data = []
    while !tickers.empty? do
      yahoo_stock_data << yahoo_stock_data_fetcher.fetch_stock_data(tickers.shift(200))
    end

    joiner = StockDataJoiner.new
    joiner.join(yahoo_stock_data.flatten)
  end
end
