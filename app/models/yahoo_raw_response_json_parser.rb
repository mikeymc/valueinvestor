require 'CSV'

class YahooRawResponseJsonParser
  def self.parse(raw_response)
    list = []
    raw_response_array = CSV.parse(raw_response)
    raw_response_array.each do |stock_obj|
      list << {
        name: stock_obj[0],
        symbol: stock_obj[1],
        exchange: stock_obj[2],
        current_eps: stock_obj[3],
        dividends_per_share: stock_obj[4],
        day_high_price: stock_obj[5],
        day_low_price: stock_obj[6],
        book_value: stock_obj[7],
        price_to_book_ratio: stock_obj[8],
        price_to_earnings_ratio: stock_obj[9],
        year_low_price: stock_obj[10],
        year_high_price: stock_obj[11]
      }
    end
    list
  end
end
