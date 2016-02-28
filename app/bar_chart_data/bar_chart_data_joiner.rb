class BarChartDataJoiner
  def join(symbol, data)
    unless data.nil?
      stock = Stock.find_by_symbol(symbol)
      stock.bar_chart_data = BarChartData.new(data)
      stock.bar_chart_data.save!
    end
  end
end
