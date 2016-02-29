class YahooKeyStatisticsDataJoiner
  def join(symbol, data)
    unless data.nil?
      stock = Stock.find_by_symbol(symbol)
      stock.yahoo_key_statistics_data = YahooKeyStatisticsData.new(data)
      stock.yahoo_key_statistics_data.save!
    end
  end
end
