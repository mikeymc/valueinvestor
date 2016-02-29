class YahooKeyStatisticsDataAggregator
  def aggregate
    yahoo_key_statistics_data_fetcher = YahooKeyStatisticsDataFetcher.new
    Stock.list_all_symbols.each do |symbol|
      data = yahoo_key_statistics_data_fetcher.fetch(symbol)
      YahooKeyStatisticsDataJoiner.new.join(symbol, data)
    end
  end
end
