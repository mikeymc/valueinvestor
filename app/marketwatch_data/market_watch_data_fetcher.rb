class MarketWatchDataFetcher
  def fetch(symbol)
    agent = Mechanize.new
    page = agent.get("http://www.marketwatch.com/investing/stock/#{symbol}/analystestimates")
    {average_recommendation: page.search('.recommendation').text.strip}
  end
end
