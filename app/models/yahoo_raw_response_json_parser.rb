require 'CSV'

class YahooRawResponseJsonParser
  def self.parse(response)
    CSV.parse(response).map do |stock|
      {
        name: clean(stock[0]),
        symbol: clean(stock[1]),
        exchange: clean(stock[2]),
        current_eps: clean(stock[3]),
        dividends_per_share: clean(stock[4]),
        day_high_price: clean(stock[5]),
        day_low_price: clean(stock[6]),
        book_value: clean(stock[7]),
        price_to_book_ratio: clean(stock[8]),
        price_to_earnings_ratio: clean(stock[9]),
        year_low_price: clean(stock[10]),
        year_high_price: clean(stock[11])
      }
    end
  end

  private

  def self.clean(input)
    input.eql?('N/A') ? '' : input
  end
end
