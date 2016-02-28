class StreetInsiderDataAggregator
  def aggregate
    street_insider_data_fetcher = StreetInsiderDataFetcher.new
    Stock.list_all_symbols.each do |symbol|
      data = street_insider_data_fetcher.fetch(symbol)
      StreetInsiderDataJoiner.new.join(symbol, data)
    end
  end
end
