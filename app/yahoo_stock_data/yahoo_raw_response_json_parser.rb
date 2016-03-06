class YahooRawResponseJsonParser
  def initialize
    @converter = NumberConverter.new
  end

  def parse(response)
    CSV.parse(response).map do |stock|
      {
        name: stock[0],
        symbol: stock[1],
        exchange: stock[2],
        current_eps: @converter.convert(stock[3]),
        dividends_per_share: @converter.convert(stock[4]),
        day_high_price: @converter.convert(stock[5]),
        day_low_price: @converter.convert(stock[6]),
        book_value: @converter.convert(stock[7]),
        price_to_book_ratio: @converter.convert(stock[8]),
        price_to_earnings_ratio: @converter.convert(stock[9]),
        year_low_price: @converter.convert(stock[10]),
        year_high_price: @converter.convert(stock[11]),
        last_trade_price: @converter.convert(stock[12]),
        ebitda: @converter.convert(stock[13]),
        market_cap: @converter.convert(stock[14]),
        one_year_target_price: @converter.convert(stock[15]),
        fifty_day_moving_average: @converter.convert(stock[16]),
        percent_change_from_fifty_day_moving_average: @converter.convert(stock[17]),
        two_hundred_day_moving_average: @converter.convert(stock[18]),
        percent_change_from_two_hundred_day_moving_average: @converter.convert(stock[19]),
        dividend_yield: @converter.convert(stock[20])
      }
    end
  end

  private

  def self.convert_to_number(input)
    (input.eql?('N/A') || input.eql?('nan')) ? nil : input.to_f
  end
end
