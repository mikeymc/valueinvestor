class BarChartDataAggregator
  def aggregate
    bar_chart_data_fetcher = BarChartDataFetcher.new
    Stock.list_all_symbols.each do |symbol|
      data = bar_chart_data_fetcher.fetch(symbol)
      BarChartDataJoiner.new.join(symbol, data)
    end
  end
end
