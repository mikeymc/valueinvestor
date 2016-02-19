require 'CSV'

class YahooRawResponseJsonParser
  def self.parse(response)
    CSV.parse(response).map do |stock|
      {
        name: stock[0],
        symbol: stock[1],
        exchange: stock[2],
        current_eps: stock[3],
        dividends_per_share: stock[4],
        day_high_price: stock[5],
        day_low_price: stock[6],
        book_value: stock[7],
        price_to_book_ratio: stock[8],
        price_to_earnings_ratio: stock[9],
        year_low_price: stock[10],
        year_high_price: stock[11]
      }
    end
  end
end
