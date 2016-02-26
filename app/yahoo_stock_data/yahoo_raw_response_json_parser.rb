require 'CSV'
require 'byebug'

class YahooRawResponseJsonParser
  def self.parse(response)
    CSV.parse(response).map do |stock|
      {
        name: stock[0],
        symbol: stock[1],
        exchange: stock[2],
        current_eps: convert_to_number(stock[3]),
        dividends_per_share: convert_to_number(stock[4]),
        day_high_price: convert_to_number(stock[5]),
        day_low_price: convert_to_number(stock[6]),
        book_value: convert_to_number(stock[7]),
        price_to_book_ratio: convert_to_number(stock[8]),
        price_to_earnings_ratio: convert_to_number(stock[9]),
        year_low_price: convert_to_number(stock[10]),
        year_high_price: convert_to_number(stock[11]),
        last_trade_price: convert_to_number(stock[12]),
        ebitda: stock[13],
        market_cap: stock[14],
        one_year_target_price: convert_to_number(stock[15]),
        fifty_day_moving_average: convert_to_number(stock[16]),
        percent_change_from_fifty_day_moving_average: convert_to_number(stock[17]),
        two_hundred_day_moving_average: convert_to_number(stock[18])
      }
    end
  end

  private

  def self.convert_to_number(input)
    (input.eql?('N/A') || input.eql?('nan')) ? nil : input.to_f
  end
end
