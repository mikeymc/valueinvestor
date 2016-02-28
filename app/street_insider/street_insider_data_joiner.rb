class StreetInsiderDataJoiner
  def join(symbol, data)
    unless data.nil?
      stock = Stock.find_by_symbol(symbol)
      stock.street_insider_data = StreetInsiderData.new(data)
      stock.street_insider_data.save!
    end
  end
end
