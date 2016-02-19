require 'rails_helper'

RSpec.describe YahooStockDataFetcher do
  it 'returns data given a list of ticker symbols' do
    first_stock_name = "\"Tiffany & Co. Common Stock\""
    first_stock_symbol = "\"TIF\""
    first_stock_exchange = "\"NYSE\""
    first_stock_current_eps = 7.58
    first_stock_dividends = 2.64
    first_stock_daily_high_price = 94.31
    first_stock_daily_low_price = 96.89
    first_stock_book_value = 42.478
    first_stock_price_to_book = 12.41
    first_stock_price_to_earnings = 44.44
    first_stock_yearly_low_price = 20.4
    first_stock_yearly_high_price = 30.5

    second_stock_name = "\"Apple Inc.\""
    second_stock_symbol = "\"AAPL\""
    second_stock_exchange = "\"Nasdaq\""
    second_stock_current_eps = 7.65
    second_stock_dividends = 1.8114
    second_stock_daily_high_price = 107.21
    second_stock_daily_low_price = 108.04
    second_stock_book_value = 19.015
    second_stock_price_to_book = 12.5
    second_stock_price_to_earnings = 55.55
    second_stock_yearly_low_price = 40.4
    second_stock_yearly_high_price = 50.5

    aapl_xom_fake_response = "#{first_stock_name},#{first_stock_symbol},#{first_stock_exchange},#{first_stock_current_eps},#{first_stock_dividends},#{first_stock_daily_high_price},#{first_stock_daily_low_price},#{first_stock_book_value},#{first_stock_price_to_book},#{first_stock_price_to_earnings},#{first_stock_yearly_low_price},#{first_stock_yearly_high_price}\n#{second_stock_name},#{second_stock_symbol},#{second_stock_exchange},#{second_stock_current_eps},#{second_stock_dividends},#{second_stock_daily_high_price},#{second_stock_daily_low_price},#{second_stock_book_value},#{second_stock_price_to_book},#{second_stock_price_to_earnings},#{second_stock_yearly_low_price},#{second_stock_yearly_high_price}\n"

    WebMock
      .disable_net_connect!
    WebMock
    .stub_request(:get, 'http://download.finance.yahoo.com/d/quotes.csv?f=nsxe7dhgb4p6rjk&s=TIF%2BAAPL%2BXOM%2BABC%2BDEF%2BGHI%2BJKL%2BMNO%2BPQR%2BSTU%2BVWX%2BYZ')
      .to_return(status: 200, body: aapl_xom_fake_response, headers: {})

    @fetcher = YahooStockDataFetcher.new
    data = @fetcher.fetch_stock_data(['TIF', 'AAPL', 'XOM', 'ABC', 'DEF', 'GHI', 'JKL', 'MNO', 'PQR', 'STU', 'VWX', 'YZ'])

    first_stock = data[0]
    expect(first_stock[:name]).to eq('Tiffany & Co. Common Stock')
    expect(first_stock[:symbol]).to eq('TIF')
    expect(first_stock[:exchange]).to eq('NYSE')
    expect(first_stock[:current_eps]).to eq('7.58')
    expect(first_stock[:dividends_per_share]).to eq('2.64')
    expect(first_stock[:day_high_price]).to eq('94.31')
    expect(first_stock[:day_low_price]).to eq('96.89')
    expect(first_stock[:book_value]).to eq('42.478')
    expect(first_stock[:price_to_book_ratio]).to eq('12.41')
    expect(first_stock[:price_to_earnings_ratio]).to eq('44.44')
    expect(first_stock[:year_low_price]).to eq('20.4')
    expect(first_stock[:year_high_price]).to eq('30.5')

    second_stock = data[1]
    expect(second_stock[:name]).to eq('Apple Inc.')
    expect(second_stock[:symbol]).to eq('AAPL')
    expect(second_stock[:exchange]).to eq('Nasdaq')
    expect(second_stock[:current_eps]).to eq('7.65')
    expect(second_stock[:dividends_per_share]).to eq('1.8114')
    expect(second_stock[:day_high_price]).to eq('107.21')
    expect(second_stock[:day_low_price]).to eq('108.04')
    expect(second_stock[:book_value]).to eq('19.015')
    expect(second_stock[:price_to_book_ratio]).to eq('12.5')
    expect(second_stock[:price_to_earnings_ratio]).to eq('55.55')
    expect(second_stock[:year_low_price]).to eq('40.4')
    expect(second_stock[:year_high_price]).to eq('50.5')
  end
end
