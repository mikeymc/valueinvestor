class BarChartDataFetcher
  def fetch(symbol)
    agent = Mechanize.new
    WebMock.allow_net_connect!
    begin
      page = agent.get("http://www.barchart.com/opinions/stocks/#{symbol}")
      {average_recommendation: page.at('b:contains("Overall") .qb_down').text.strip}
    rescue
      nil
    end
  end
end
