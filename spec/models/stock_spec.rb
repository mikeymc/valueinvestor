require 'rails_helper'

RSpec.describe Stock, :type => :model do
  raw_response = "\"Exxon Mobil Corpo\",\"XOM\",\"NYSE\",7.58\r\n\"Apple Inc.\",\"AAPL\",\"NasdaqNM\",7.65\r\n"
  describe 'parse_stocks' do
    it 'should parse a raw string response from yahoo into stock objects' do
      Stock.parse_stocks(raw_response)
      expect(Stock.all.size).to be(2)
    end
    it 'parses the raw string response into the correct fields of the stock object' do
      Stock.parse_stocks(raw_response)
      found_stock = Stock.find_by_symbol("XOM")
      expect(found_stock.name).to eq("Exxon Mobil Corpo")
      expect(found_stock.symbol).to eq("XOM")
      expect(found_stock.index).to eq("NYSE")
      expect(found_stock.currentEPS).to eq("7.58")
    end
  end
end
