class YahooDataAggregator
  def aggregate
    data = fetch_data
    YahooDataJoiner.new.join(data.flatten)
  end

  def find_broke
    stocks = []
    Stock.all.each do |stock|
      begin
        stocks << stock.symbol
        stock.yahoo_data.current_eps
      rescue
        debugger
      end
    end
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
