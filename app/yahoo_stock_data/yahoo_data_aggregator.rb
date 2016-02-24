class YahooDataAggregator
  def aggregate
    data = fetch_data
    StockDataJoiner.new.join(data.flatten)
  end

  private

  def fetch_data
    fetcher = YahooStockDataFetcher.new
    tickers = Stock.list_all_symbols
    tickers.map! { |ticker| ticker.strip }
    yahoo_stock_data = []
    while !tickers.empty? do
      yahoo_stock_data << fetcher.fetch_stock_data(tickers.shift(200))
    end
    yahoo_stock_data
  end
end
