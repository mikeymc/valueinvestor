class Stock < ActiveRecord::Base
  def self.parse_stocks(raw_response)
    raw_response_array = raw_response.delete("\"").split("\r\n")
    raw_response_array.each do |stock_obj|
      stock_obj = stock_obj.split(',')
      stock = Stock.new
      stock.name = stock_obj[0]
      stock.symbol = stock_obj[1]
      stock.index = stock_obj[2]
      stock.currentEPS = stock_obj[3]
      stock.save!
    end
  end
end
