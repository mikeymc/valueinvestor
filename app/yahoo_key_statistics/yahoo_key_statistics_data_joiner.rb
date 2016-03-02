class YahooKeyStatisticsDataJoiner
  def join(symbol, data)
    unless data.nil?
      stock = Stock.find_by_symbol(symbol)

      ebitda = stock.yahoo_data.ebitda
      ev = data[:enterprise_value]
      unless ev.nil? or ebitda.nil?
        data[:ebitda_to_ev] = ebitda / ev
      end

      stock.yahoo_key_statistics_data = YahooKeyStatisticsData.new(data)
      stock.yahoo_key_statistics_data.save!
    end
  end
end
