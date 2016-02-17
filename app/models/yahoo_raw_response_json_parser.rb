class YahooRawResponseJsonParser
  def self.parse(raw_response)
    list = []
    raw_response_array = raw_response.delete("\"").split("\n")
    raw_response_array.each do |stock_obj|
      stock_obj = stock_obj.split(/,(?![\s,])/)
      stock_hash = {
        name: stock_obj[0],
        symbol: stock_obj[1],
        index: stock_obj[2],
        currentEPS: stock_obj[3],
        dividends_per_share: stock_obj[4],
        day_high_price: stock_obj[5],
        day_low_price: stock_obj[6],
        book_value: stock_obj[7],
        price_to_book_ratio: stock_obj[8]
      }
      list << stock_hash
    end
    list
  end
end
