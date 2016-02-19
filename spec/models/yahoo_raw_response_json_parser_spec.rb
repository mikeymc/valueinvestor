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

  AAPL_XOM_FAKE_RESPONSE = "#{first_stock_name},#{first_stock_symbol},#{first_stock_exchange},#{first_stock_current_eps},#{first_stock_dividends},#{first_stock_daily_high_price},#{first_stock_daily_low_price},#{first_stock_book_value},#{first_stock_price_to_book},#{first_stock_price_to_earnings}\n#{second_stock_name},#{second_stock_symbol},#{second_stock_exchange},#{second_stock_current_eps},#{second_stock_dividends},#{second_stock_daily_high_price},#{second_stock_daily_low_price},#{second_stock_book_value},#{second_stock_price_to_book},#{second_stock_price_to_earnings}\n"
  
  describe 'parse_to_json' do
    it 'returns a list' do
      list = YahooRawResponseJsonParser.parse(AAPL_XOM_FAKE_RESPONSE)
      expect(list.size).to be >= 0
    end

    it 'populates a response that contains two items' do
      list = YahooRawResponseJsonParser.parse AAPL_XOM_FAKE_RESPONSE
      first_stock = list[0]
      second_stock = list[1]

      expect(first_stock[:name]).to eq('Exxon Mobil Corpo')
      expect(first_stock[:symbol]).to eq('XOM')
      expect(first_stock[:exchange]).to eq('NYSE')
      expect(first_stock[:current_eps]).to eq('7.58')
      expect(first_stock[:dividends_per_share]).to eq('2.64')
      expect(first_stock[:day_high_price]).to eq('94.31')
      expect(first_stock[:day_low_price]).to eq('96.89')
      expect(first_stock[:book_value]).to eq('42.478')
      expect(first_stock[:price_to_book_ratio]).to eq('12.4')
      expect(first_stock[:price_to_earnings_ratio]).to eq('44.44')

      expect(second_stock[:name]).to eq('Apple Inc.')
      expect(second_stock[:symbol]).to eq('AAPL')
      expect(second_stock[:exchange]).to eq('Nasdaq')
      expect(second_stock[:current_eps]).to eq('7.65')
      expect(second_stock[:dividends_per_share]).to eq('1.8114')
      expect(second_stock[:day_high_price]).to eq('107.21')
      expect(second_stock[:day_low_price]).to eq('108.04')
      expect(second_stock[:book_value]).to eq('19.015')
      expect(second_stock[:price_to_book_ratio]).to eq('12.5')
      expect(second_stock[:price_to_earnings_ratio]).to eq('55.55')
    end
    it 'correctly splits when a company has a ", Inc" in its name' do
      raw_response = "\"Bemis Company, In\",\"BMS\",\"NYSE\",2.32,5.335,4.444,5.555,6.666,12"
      list = YahooRawResponseJsonParser.parse raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('Bemis Company, In')
      expect(first_stock[:exchange]).to eq('NYSE')
      expect(first_stock[:symbol]).to eq('BMS')
      expect(first_stock[:current_eps]).to eq('2.32')
      expect(first_stock[:dividends_per_share]).to eq('5.335')
      expect(first_stock[:day_high_price]).to eq('4.444')
      expect(first_stock[:day_low_price]).to eq('5.555')
      expect(first_stock[:book_value]).to eq('6.666')
      expect(first_stock[:price_to_book_ratio]).to eq('12')
    end
    it 'correctly splits "FMC Technologies,"' do
      raw_response = "\"FMC Technologies,\",\"FTI\",\"NYSE\",2.86,1.111,5.555,4.444"
      list = YahooRawResponseJsonParser.parse raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('FMC Technologies,')
      expect(first_stock[:exchange]).to eq('NYSE')
      expect(first_stock[:symbol]).to eq('FTI')
      expect(first_stock[:current_eps]).to eq('2.86')
      expect(first_stock[:dividends_per_share]).to eq('1.111')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'correctly splits "3D EYE SOLUTIONS,"' do
      raw_response = "\"3D EYE SOLUTIONS,\",\"TDEY\",\"Other OTC\",0.00,4.234,5.555,4.444"
      list = YahooRawResponseJsonParser.parse raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('3D EYE SOLUTIONS,')
      expect(first_stock[:symbol]).to eq('TDEY')
      expect(first_stock[:exchange]).to eq('Other OTC')
      expect(first_stock[:current_eps]).to eq('0.00')
      expect(first_stock[:dividends_per_share]).to eq('4.234')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'correctly splits "ONEX CORPORATION,"' do
      raw_response = "\"ONEX CORPORATION,\",\"OCX.TO\",\"Toronto\",0.95,0,5.555,4.444"
      list = YahooRawResponseJsonParser.parse raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('ONEX CORPORATION,')
      expect(first_stock[:symbol]).to eq('OCX.TO')
      expect(first_stock[:exchange]).to eq('Toronto')
      expect(first_stock[:current_eps]).to eq('0.95')
      expect(first_stock[:dividends_per_share]).to eq('0')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'correctly splits "Eaton Vance Penns"' do
      raw_response = "\"Eaton Vance Penns\",\"EIP\",\"AMEX\",0.00,9.999,5.555,4.444"
      list = YahooRawResponseJsonParser.parse raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('Eaton Vance Penns')
      expect(first_stock[:symbol]).to eq('EIP')
      expect(first_stock[:exchange]).to eq('AMEX')
      expect(first_stock[:current_eps]).to eq('0.00')
      expect(first_stock[:dividends_per_share]).to eq('9.999')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'correctly splits "Brookfield Infras"' do
      raw_response = "\"Brookfield Infras\",\"BIP\",\"NYSE\",1.30,1.00,5.555,4.444"
      list = YahooRawResponseJsonParser.parse raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('Brookfield Infras')
      expect(first_stock[:symbol]).to eq('BIP')
      expect(first_stock[:exchange]).to eq('NYSE')
      expect(first_stock[:current_eps]).to eq('1.30')
      expect(first_stock[:dividends_per_share]).to eq('1.00')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'correctly splits "Sinclair Broadcas"' do
      raw_response = "\"Sinclair Broadcas\",\"SBGI\",\"NasdaqNM\",1.83,5.3,5.555,4.444"
      list = YahooRawResponseJsonParser.parse raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('Sinclair Broadcas')
      expect(first_stock[:symbol]).to eq('SBGI')
      expect(first_stock[:exchange]).to eq('NasdaqNM')
      expect(first_stock[:current_eps]).to eq('1.83')
      expect(first_stock[:dividends_per_share]).to eq('5.3')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'correctly splits "CRA International"' do
      raw_response = "\"CRA International,Inc.\",\"CRAI\",\"NMS\",1.29,N/A,17.11,16.79,24.21,0.70,12.35,16.25,32.47"
      list = YahooRawResponseJsonParser.parse raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('CRA International,Inc.')
      expect(first_stock[:symbol]).to eq('CRAI')
      expect(first_stock[:exchange]).to eq('NMS')
      expect(first_stock[:current_eps]).to eq('1.29')
      expect(first_stock[:dividends_per_share]).to eq('N/A')
      expect(first_stock[:day_high_price]).to eq('17.11')
      expect(first_stock[:day_low_price]).to eq('16.79')
      expect(first_stock[:book_value]).to eq('24.21')
      expect(first_stock[:price_to_book_ratio]).to eq('0.70')
      expect(first_stock[:price_to_earnings_ratio]).to eq('12.35')
    end
    it 'correctly splits TIF and RGDX' do
      raw_response = "\"Tiffany & Co. Common Stock\",\"TIF\",\"NYQ\",3.78,1.60,61.91,60.43,22.25,2.73\n\"Response Genetics, Inc.\",\"RGDX\",\"NCM\",-0.190,N/A,N/A,N/A,0.000,N/A"
      list = YahooRawResponseJsonParser.parse raw_response

      first_stock = list[0]
      expect(first_stock[:name]).to eq('Tiffany & Co. Common Stock')
      expect(first_stock[:symbol]).to eq('TIF')
      expect(first_stock[:exchange]).to eq('NYQ')
      expect(first_stock[:current_eps]).to eq('3.78')
      expect(first_stock[:dividends_per_share]).to eq('1.60')
      expect(first_stock[:day_high_price]).to eq('61.91')
      expect(first_stock[:day_low_price]).to eq('60.43')
      expect(first_stock[:book_value]).to eq('22.25')
      expect(first_stock[:price_to_book_ratio]).to eq('2.73')

      second_stock = list[1]
      expect(second_stock[:name]).to eq('Response Genetics, Inc.')
      expect(second_stock[:symbol]).to eq('RGDX')
      expect(second_stock[:exchange]).to eq('NCM')
      expect(second_stock[:current_eps]).to eq('-0.190')
      expect(second_stock[:dividends_per_share]).to eq('N/A')
      expect(second_stock[:day_high_price]).to eq('N/A')
      expect(second_stock[:day_low_price]).to eq('N/A')
      expect(second_stock[:book_value]).to eq('0.000')
      expect(second_stock[:price_to_book_ratio]).to eq('N/A')
    end
  end
end
