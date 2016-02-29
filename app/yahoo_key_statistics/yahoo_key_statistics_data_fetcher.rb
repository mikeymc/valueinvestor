class YahooKeyStatisticsDataFetcher
  def fetch(symbol)
    agent = Mechanize.new
    converter = NumberConverter.new
    WebMock.allow_net_connect!
    begin
      page = agent.get("http://finance.yahoo.com/q/ks?s=#{symbol}")
      {
        enterprise_value: converter.convert(page.search('table table table').first.at('tr:nth(2) td:nth(2)').text),
        profit_margin: converter.convert(page.search('table table table')[2].at('tr:nth(2) td:nth(2)').text),
        operating_margin: converter.convert(page.search('table table table')[2].at('tr:nth(3) td:nth(2)').text),
        return_on_assets: converter.convert(page.search('table table table')[3].at('tr:nth(2) td:nth(2)').text),
        return_on_equity: converter.convert(page.search('table table table')[3].at('tr:nth(3) td:nth(2)').text),
        beta: converter.convert(page.search('table table table')[7].at('tr:nth(2) td:nth(2)').text)
      }
    rescue
      nil
    end
  end
end
