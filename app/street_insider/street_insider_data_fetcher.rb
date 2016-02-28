class StreetInsiderDataFetcher
  def fetch(symbol)
    agent = Mechanize.new
    WebMock.allow_net_connect!
    begin
      page = agent.get("http://www.streetinsider.com/rating_history.php?q=#{symbol}")
      {average_recommendation: page.search('#content div').search('span').first.text}
    rescue
      nil
    end
  end
end
