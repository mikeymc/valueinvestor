require 'CGI'

class YahooStockDataFetcher
  attr_accessor :list

  def fetch_stock_data(tickers)
    response = make_request tickers
    YahooRawResponseJsonParser.parse response
  end

  private

  def make_request(stock_list)
    WebMock.allow_net_connect!
    Net::HTTP.get('download.finance.yahoo.com', '/d/quotes.csv?s=' + CGI::escape(stocks(stock_list)) + '&f=' + options)
  end

  def stocks(stock_list)
    stocks_for_uri = '' + stock_list.shift
    stock_list.each { |symbol| stocks_for_uri = stocks_for_uri + '+' + stock_list.shift }
    stocks_for_uri
  end

  def options
    name = 'n'
    symbol = 's'
    exchange = 'x'
    estimated_current_eps = 'e7'
    dividends_per_share = 'd'
    daily_low_price = 'g'
    daily_high_price = 'h'
    book_value = 'b4'
    price_to_book_ratio = 'p6'

    name+symbol+exchange+estimated_current_eps+dividends_per_share+daily_high_price+daily_low_price+book_value+price_to_book_ratio
  end

end
