class YahooKeyStatisticsDataAggregator
  def aggregate
    yahoo_key_statistics_data = YahooKeyStatisticsDataFetcher.new
    Stock.list_all_symbols.each do |symbol|
      data = yahoo_key_statistics_data.fetch(symbol)
      YahooKeyStatisticsDataJoiner.new.join(symbol, data)
    end
  end
end
