require 'rails_helper'

RSpec.describe YahooRawResponseJsonParser do
  first_stock_name = "\"Exxon Mobil Corpo\""
  first_stock_symbol = "\"XOM\""
  first_stock_exchange = "\"NYSE\""
  first_stock_current_eps = 7.58
  first_stock_dividends = 2.64
  first_stock_daily_high_price = 94.31
  first_stock_daily_low_price = 96.89
  first_stock_book_value = 42.478
  first_stock_price_to_book = 12.4
  first_stock_price_to_earnings = 44.44
  first_stock_last_trade_price = 44.44
  first_stock_yearly_low_price = 44.44
  first_stock_yearly_high_price = 44.44
  first_stock_one_year_target_price = 44.44
  first_stock_fifty_day_moving_average = 44.44
  first_stock_percent_change_from_fifty_day_moving_average = 44.44
  first_stock_two_hundred_day_moving_average = 44.44
  first_stock_percent_change_from_two_hundred_day_moving_average = 44.44
  first_stock_dividend_yield = 44.44
  first_stock_market_cap = "\"1.34B\""
  first_stock_ebitda = "\"2.45B\""

  second_stock_name = "\"Apple Inc.\""
  second_stock_symbol = "\"AAPL\""
  second_stock_exchange = "\"Nasdaq\""
  second_stock_current_eps = 7.65
  second_stock_dividends = 'nan'
  second_stock_daily_high_price = 107.21
  second_stock_daily_low_price = 108.04
  second_stock_book_value = 19.015
  second_stock_price_to_book = 'N/A'
  second_stock_price_to_earnings = 55.55
  second_stock_ebitda = "\"2.2M\""
  second_stock_market_cap = "\"7.89.M\""
  second_stock_last_trade_price = 44.44
  second_stock_yearly_low_price = 44.44
  second_stock_yearly_high_price = 44.44
  second_stock_one_year_target_price = 44.44
  second_stock_fifty_day_moving_average = 44.44
  second_stock_percent_change_from_fifty_day_moving_average = 44.44
  second_stock_two_hundred_day_moving_average = 44.44
  second_stock_percent_change_from_two_hundred_day_moving_average = 44.44
  second_stock_dividend_yield = 44.44

  aapl_xom_fake_response =
    "#{first_stock_name}," +
      "#{first_stock_symbol}," +
      "#{first_stock_exchange}," +
      "#{first_stock_current_eps}," +
      "#{first_stock_dividends}," +
      "#{first_stock_daily_high_price}," +
      "#{first_stock_daily_low_price}," +
      "#{first_stock_book_value}," +
      "#{first_stock_price_to_book}," +
      "#{first_stock_price_to_earnings}," +
      "#{first_stock_yearly_low_price}," +
      "#{first_stock_yearly_high_price}," +
      "#{first_stock_last_trade_price}," +
      "#{first_stock_ebitda}," +
      "#{first_stock_market_cap}," +
      "#{first_stock_one_year_target_price}," +
      "#{first_stock_fifty_day_moving_average}," +
      "#{first_stock_percent_change_from_fifty_day_moving_average}," +
      "#{first_stock_two_hundred_day_moving_average}," +
      "#{first_stock_percent_change_from_two_hundred_day_moving_average}," +
      "#{first_stock_dividend_yield}\n" +
      "#{second_stock_name}," +
      "#{second_stock_symbol}," +
      "#{second_stock_exchange}," +
      "#{second_stock_current_eps}," +
      "#{second_stock_dividends}," +
      "#{second_stock_daily_high_price}," +
      "#{second_stock_daily_low_price}," +
      "#{second_stock_book_value}," +
      "#{second_stock_price_to_book}," +
      "#{second_stock_price_to_earnings}," +
      "#{second_stock_yearly_low_price}," +
      "#{second_stock_yearly_high_price}," +
      "#{second_stock_last_trade_price}," +
      "#{second_stock_ebitda}," +
      "#{second_stock_market_cap}," +
      "#{second_stock_one_year_target_price}," +
      "#{second_stock_fifty_day_moving_average}," +
      "#{second_stock_percent_change_from_fifty_day_moving_average}," +
      "#{second_stock_two_hundred_day_moving_average}," +
      "#{second_stock_percent_change_from_two_hundred_day_moving_average}," +
      "#{second_stock_dividend_yield}\n"

  describe 'parse_to_json' do
    it 'parses raw responses to lists of stock hashes' do
      list = YahooRawResponseJsonParser.new.parse aapl_xom_fake_response
      first_stock = list[0]
      second_stock = list[1]

      expect(first_stock[:name]).to eq('Exxon Mobil Corpo')
      expect(first_stock[:symbol]).to eq('XOM')
      expect(first_stock[:exchange]).to eq('NYSE')
      expect(first_stock[:current_eps]).to eq(7.58)
      expect(first_stock[:dividends_per_share]).to eq(2.64)
      expect(first_stock[:day_high_price]).to eq(94.31)
      expect(first_stock[:day_low_price]).to eq(96.89)
      expect(first_stock[:book_value]).to eq(42.478)
      expect(first_stock[:price_to_book_ratio]).to eq(12.4)
      expect(first_stock[:price_to_earnings_ratio]).to eq(44.44)
      expect(first_stock[:market_cap]).to eq(1340000000)
      expect(first_stock[:ebitda]).to eq(2450000000)

      expect(second_stock[:name]).to eq('Apple Inc.')
      expect(second_stock[:symbol]).to eq('AAPL')
      expect(second_stock[:exchange]).to eq('Nasdaq')
      expect(second_stock[:current_eps]).to eq(7.65)
      expect(second_stock[:dividends_per_share]).to be_nil
      expect(second_stock[:day_high_price]).to eq(107.21)
      expect(second_stock[:day_low_price]).to eq(108.04)
      expect(second_stock[:book_value]).to eq(19.015)
      expect(second_stock[:price_to_book_ratio]).to be_nil
      expect(second_stock[:price_to_earnings_ratio]).to eq(55.55)
    end
  end
end
