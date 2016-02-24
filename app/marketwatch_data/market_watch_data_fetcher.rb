class MarketWatchDataFetcher
  def fetch(symbol)
    agent = Mechanize.new
    begin
      page = agent.get("http://www.marketwatch.com/investing/stock/#{symbol}/analystestimates")
      {average_recommendation: page.search('.recommendation').text.strip}
    rescue
      nil
    end
  end
end
