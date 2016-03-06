class YahooStockDataFetcher
  attr_accessor :list

  def fetch_stock_data(tickers)
    response = make_request tickers
    YahooRawResponseJsonParser.new.parse response
  end

  private

  def make_request(stock_list)
    WebMock.allow_net_connect!
    Net::HTTP.get('download.finance.yahoo.com', '/d/quotes.csv?s=' + escape(stock_list) + '&f=' + options)
  end

  def escape(stocks)
    CGI::escape(stocks.join('+'))
  end

  def options
    {
      :name => 'n',
      :symbol => 's',
      :exchange => 'x',
      :estimated_current_eps => 'e7',
      :dividends_per_share => 'd',
      :daily_high_price => 'h',
      :daily_low_price => 'g',
      :book_value => 'b4',
      :price_to_book_ratio => 'p6',
      :price_to_earnings_ratio => 'r',
      :yearly_low_price => 'j',
      :yearly_high_price => 'k',
      :last_trade_price => 'l1',
      :ebitda => 'j4',
      :market_cap => 'j1',
      :one_year_target_price => 't8',
      :fifty_day_moving_average => 'm3',
      :percent_change_from_fifty_day_moving_average => 'm8',
      :two_hundred_day_moving_average => 'm4',
      :percent_change_from_two_hundred_day_moving_average => 'm6',
      :dividend_yield => 'y'
    }.values.join('')
  end
end
