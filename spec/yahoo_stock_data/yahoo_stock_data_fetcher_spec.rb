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
    first_stock_ebitda = "\"1.01B\""
    first_stock_last_trade_price = 65.12
    first_stock_market_cap = "\"8.35B\""
    first_stock_one_year_target_price = 82.26
    first_stock_fifty_day_moving_average = 64.24
    first_stock_percent_change_from_fifty_day_moving_average = "\"+1.38%\""
    first_stock_two_hundred_day_moving_average = 75.94
    first_stock_percent_change_from_two_hundred_day_moving_average = -14.25

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
    second_stock_ebitda = "\"82.79B\""
    second_stock_last_trade_price = 96.76
    second_stock_market_cap = "\"536.49B\""
    second_stock_one_year_target_price = 135.92
    second_stock_fifty_day_moving_average = 96.55
    second_stock_percent_change_from_fifty_day_moving_average = "\"+0.22%\""
    second_stock_two_hundred_day_moving_average = 109.26
    second_stock_percent_change_from_two_hundred_day_moving_average = -11.44

    aapl_xom_fake_response = ''

    aapl_xom_fake_response << "#{first_stock_name},"
    aapl_xom_fake_response << "#{first_stock_symbol},"
    aapl_xom_fake_response << "#{first_stock_exchange},"
    aapl_xom_fake_response << "#{first_stock_current_eps},"
    aapl_xom_fake_response << "#{first_stock_dividends},"
    aapl_xom_fake_response << "#{first_stock_daily_high_price},"
    aapl_xom_fake_response << "#{first_stock_daily_low_price},"
    aapl_xom_fake_response << "#{first_stock_book_value},"
    aapl_xom_fake_response << "#{first_stock_price_to_book},"
    aapl_xom_fake_response << "#{first_stock_price_to_earnings},"
    aapl_xom_fake_response << "#{first_stock_yearly_low_price},"
    aapl_xom_fake_response << "#{first_stock_yearly_high_price},"
    aapl_xom_fake_response << "#{first_stock_last_trade_price},"
    aapl_xom_fake_response << "#{first_stock_ebitda},"
    aapl_xom_fake_response << "#{first_stock_market_cap},"
    aapl_xom_fake_response << "#{first_stock_one_year_target_price},"
    aapl_xom_fake_response << "#{first_stock_fifty_day_moving_average},"
    aapl_xom_fake_response << "#{first_stock_percent_change_from_fifty_day_moving_average},"
    aapl_xom_fake_response << "#{first_stock_two_hundred_day_moving_average},"
    aapl_xom_fake_response << "#{first_stock_percent_change_from_two_hundred_day_moving_average}\n"

    aapl_xom_fake_response << "#{second_stock_name},"
    aapl_xom_fake_response << "#{second_stock_symbol},"
    aapl_xom_fake_response << "#{second_stock_exchange},"
    aapl_xom_fake_response << "#{second_stock_current_eps},"
    aapl_xom_fake_response << "#{second_stock_dividends},"
    aapl_xom_fake_response << "#{second_stock_daily_high_price},"
    aapl_xom_fake_response << "#{second_stock_daily_low_price},"
    aapl_xom_fake_response << "#{second_stock_book_value},"
    aapl_xom_fake_response << "#{second_stock_price_to_book},"
    aapl_xom_fake_response << "#{second_stock_price_to_earnings},"
    aapl_xom_fake_response << "#{second_stock_yearly_low_price},"
    aapl_xom_fake_response << "#{second_stock_yearly_high_price},"
    aapl_xom_fake_response << "#{second_stock_last_trade_price},"
    aapl_xom_fake_response << "#{second_stock_ebitda},"
    aapl_xom_fake_response << "#{second_stock_market_cap},"
    aapl_xom_fake_response << "#{second_stock_one_year_target_price},"
    aapl_xom_fake_response << "#{second_stock_fifty_day_moving_average},"
    aapl_xom_fake_response << "#{second_stock_percent_change_from_fifty_day_moving_average},"
    aapl_xom_fake_response << "#{second_stock_two_hundred_day_moving_average},"
    aapl_xom_fake_response << "#{second_stock_percent_change_from_two_hundred_day_moving_average}\n"

    WebMock
      .stub_request(:get, 'http://download.finance.yahoo.com/d/quotes.csv?f=nsxe7dhgb4p6rjkl1j4j1t8m3m8m4m6&s=TIF%2BAAPL')
      .to_return(status: 200, body: aapl_xom_fake_response, headers: {})

    @fetcher = YahooStockDataFetcher.new
    data = @fetcher.fetch_stock_data(['TIF', 'AAPL'])

    first_stock = data[0]
    expect(first_stock[:name]).to eq('Tiffany & Co. Common Stock')
    expect(first_stock[:symbol]).to eq('TIF')
    expect(first_stock[:exchange]).to eq('NYSE')
    expect(first_stock[:current_eps]).to eq(7.58)
    expect(first_stock[:dividends_per_share]).to eq(2.64)
    expect(first_stock[:day_high_price]).to eq(94.31)
    expect(first_stock[:day_low_price]).to eq(96.89)
    expect(first_stock[:book_value]).to eq(42.478)
    expect(first_stock[:price_to_book_ratio]).to eq(12.41)
    expect(first_stock[:price_to_earnings_ratio]).to eq(44.44)
    expect(first_stock[:year_low_price]).to eq(20.4)
    expect(first_stock[:year_high_price]).to eq(30.5)
    expect(first_stock[:ebitda]).to eq('1.01B')
    expect(first_stock[:last_trade_price]).to eq(65.12)
    expect(first_stock[:market_cap]).to eq('8.35B')
    expect(first_stock[:one_year_target_price]).to eq(82.26)
    expect(first_stock[:fifty_day_moving_average]).to eq(64.24)
    expect(first_stock[:percent_change_from_fifty_day_moving_average]).to eq(1.38)
    expect(first_stock[:two_hundred_day_moving_average]).to eq(75.94)
    expect(first_stock[:percent_change_from_two_hundred_day_moving_average]).to eq(-14.25)

    second_stock = data[1]
    expect(second_stock[:name]).to eq('Apple Inc.')
    expect(second_stock[:symbol]).to eq('AAPL')
    expect(second_stock[:exchange]).to eq('Nasdaq')
    expect(second_stock[:current_eps]).to eq(7.65)
    expect(second_stock[:dividends_per_share]).to eq(1.8114)
    expect(second_stock[:day_high_price]).to eq(107.21)
    expect(second_stock[:day_low_price]).to eq(108.04)
    expect(second_stock[:book_value]).to eq(19.015)
    expect(second_stock[:price_to_book_ratio]).to eq(12.5)
    expect(second_stock[:price_to_earnings_ratio]).to eq(55.55)
    expect(second_stock[:year_low_price]).to eq(40.4)
    expect(second_stock[:year_high_price]).to eq(50.5)
    expect(second_stock[:ebitda]).to eq('82.79B')
    expect(second_stock[:last_trade_price]).to eq(96.76)
    expect(second_stock[:market_cap]).to eq('536.49B')
    expect(second_stock[:one_year_target_price]).to eq(135.92)
    expect(second_stock[:fifty_day_moving_average]).to eq(96.55)
    expect(second_stock[:percent_change_from_fifty_day_moving_average]).to eq(0.22)
    expect(second_stock[:two_hundred_day_moving_average]).to eq(109.26)
    expect(second_stock[:percent_change_from_two_hundred_day_moving_average]).to eq(-11.44)
  end
end
