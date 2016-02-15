require 'rails_helper'

RSpec.describe QuerySetup  do
  aapl_xom = "\"Exxon Mobil Corpo\",\"XOM\",\"NYSE\",7.58,2.64,94.31,96.89,42.478\r\n\"Apple Inc.\",\"AAPL\",\"NasdaqNM\",7.65,1.8114,107.21,108.04,19.015\r\n"

  describe 'getting_the_initial_stock_ticker_list' do
    it 'should have 14939 items' do
      @qs = QuerySetup.new
      @qs.generate_list
      expect(@qs.list.size).to eq(14935)
    end
    it 'should only contain symbols' do
      @qs = QuerySetup.new
      @qs.generate_list
      expect(@qs.list[0]).to eq('TIF')
    end
  end

  describe 'make_request' do
    expected_response = 'expected_response'
    it 'should call the right api endpoint with more than one stock symbol passed in' do
      WebMock.stub_request(:get, "http://download.finance.yahoo.com/d/quotes.csv?s=XOM+AAPL&f=nsxe7dhgb4p6")
        .with(headers: {'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby'})
        .to_return(status: 200, body: expected_response, headers: {})
      response = QuerySetup.new.make_request(['XOM', 'AAPL'])
      expect(response.body).to eq(expected_response)
    end
    it 'should build the right URI with one stock symbol passed in' do
      WebMock.stub_request(:get, "http://download.finance.yahoo.com/d/quotes.csv?s=XOM&f=nsxe7dhgb4p6")
        .with(headers: {'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby'})
        .to_return(status: 200, body: expected_response, headers: {})
      response = QuerySetup.new.make_request(['XOM'])
      expect(response.body).to eq(expected_response)
    end
  end

  describe 'parse_raw_response_to_json' do
    it 'should return a list' do
      list = QuerySetup.parse_raw_response_to_json(aapl_xom)
      expect(list.size).to be >= 0
    end
    it 'should correctly populate a response with two items' do
      list = QuerySetup.parse_raw_response_to_json aapl_xom
      first_stock = list[0]
      second_stock = list[1]

      expect(first_stock[:name]).to eq('Exxon Mobil Corpo')
      expect(first_stock[:index]).to eq('NYSE')
      expect(first_stock[:symbol]).to eq('XOM')
      expect(first_stock[:currentEPS]).to eq('7.58')
      expect(first_stock[:dividends_per_share]).to eq('2.64')
      expect(first_stock[:book_value]).to eq('42.478')

      expect(second_stock[:name]).to eq('Apple Inc.')
      expect(second_stock[:index]).to eq('NasdaqNM')
      expect(second_stock[:symbol]).to eq('AAPL')
      expect(second_stock[:currentEPS]).to eq('7.65')
      expect(second_stock[:dividends_per_share]).to eq('1.8114')
      expect(second_stock[:book_value]).to eq('19.015')
    end
    it 'should correctly split when a company has a ', Inc' in its name' do
      raw_response = "\"Bemis Company, In\",\"BMS\",\"NYSE\",2.32,5.335,4.444,5.555,6.666,12"
      list = QuerySetup.parse_raw_response_to_json raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('Bemis Company, In')
      expect(first_stock[:index]).to eq('NYSE')
      expect(first_stock[:symbol]).to eq('BMS')
      expect(first_stock[:currentEPS]).to eq('2.32')
      expect(first_stock[:dividends_per_share]).to eq('5.335')
      expect(first_stock[:day_high_price]).to eq('4.444')
      expect(first_stock[:day_low_price]).to eq('5.555')
      expect(first_stock[:book_value]).to eq('6.666')
      expect(first_stock[:price_to_book_ratio]).to eq('12')
    end
    it 'should correctly split "FMC Technologies,"' do
      raw_response = "\FMC Technologies,\",\"FTI\",\"NYSE\",2.86,1.111,5.555,4.444"
      list = QuerySetup.parse_raw_response_to_json raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('FMC Technologies,')
      expect(first_stock[:index]).to eq('NYSE')
      expect(first_stock[:symbol]).to eq('FTI')
      expect(first_stock[:currentEPS]).to eq('2.86')
      expect(first_stock[:dividends_per_share]).to eq('1.111')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'should correctly split "3D EYE SOLUTIONS,"' do
      raw_response = "\"3D EYE SOLUTIONS,\",\"TDEY\",\"Other OTC\",0.00,4.234,5.555,4.444"
      list = QuerySetup.parse_raw_response_to_json raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('3D EYE SOLUTIONS,')
      expect(first_stock[:symbol]).to eq('TDEY')
      expect(first_stock[:index]).to eq('Other OTC')
      expect(first_stock[:currentEPS]).to eq('0.00')
      expect(first_stock[:dividends_per_share]).to eq('4.234')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'should correctly split "ONEX CORPORATION,"' do
      raw_response = "\"ONEX CORPORATION,\",\"OCX.TO\",\"Toronto\",0.95,0,5.555,4.444"
      list = QuerySetup.parse_raw_response_to_json raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('ONEX CORPORATION,')
      expect(first_stock[:symbol]).to eq('OCX.TO')
      expect(first_stock[:index]).to eq('Toronto')
      expect(first_stock[:currentEPS]).to eq('0.95')
      expect(first_stock[:dividends_per_share]).to eq('0')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'should correctly split "Eaton Vance Penns"' do
      raw_response = "\"Eaton Vance Penns\",\"EIP\",\"AMEX\",0.00,9.999,5.555,4.444"
      list = QuerySetup.parse_raw_response_to_json raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('Eaton Vance Penns')
      expect(first_stock[:symbol]).to eq('EIP')
      expect(first_stock[:index]).to eq('AMEX')
      expect(first_stock[:currentEPS]).to eq('0.00')
      expect(first_stock[:dividends_per_share]).to eq('9.999')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'should correctly split "Brookfield Infras"' do
      raw_response = "\"Brookfield Infras\",\"BIP\",\"NYSE\",1.30,1.00,5.555,4.444"
      list = QuerySetup.parse_raw_response_to_json raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('Brookfield Infras')
      expect(first_stock[:symbol]).to eq('BIP')
      expect(first_stock[:index]).to eq('NYSE')
      expect(first_stock[:currentEPS]).to eq('1.30')
      expect(first_stock[:dividends_per_share]).to eq('1.00')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
    it 'should correctly split "Sinclair Broadcas"' do
      raw_response = "\"Sinclair Broadcas\",\"SBGI\",\"NasdaqNM\",1.83,5.3,5.555,4.444"
      list = QuerySetup.parse_raw_response_to_json raw_response
      first_stock = list[0]
      expect(first_stock[:name]).to eq('Sinclair Broadcas')
      expect(first_stock[:symbol]).to eq('SBGI')
      expect(first_stock[:index]).to eq('NasdaqNM')
      expect(first_stock[:currentEPS]).to eq('1.83')
      expect(first_stock[:dividends_per_share]).to eq('5.3')
      expect(first_stock[:day_high_price]).to eq('5.555')
      expect(first_stock[:day_low_price]).to eq('4.444')
    end
  end

  describe 'get_next_200' do
    it 'should return the next 200 items' do
      list = [*1..400]
      @qs = QuerySetup.new
      @qs.list = list
      first = @qs.get_next_200
      expect(first.size).to eq(200)
      second = @qs.get_next_200
      expect(second.size).to eq(200)
    end
    it 'should return the remaining items if less than 200 remain' do
      list = [*1..205]
      @qs = QuerySetup.new
      @qs.list = list
      first = @qs.get_next_200
      expect(first.size).to eq(200)
      second = @qs.get_next_200
      expect(second.size).to eq(5)
      third = @qs.get_next_200
      expect(third.size).to eq(0)
    end
  end
end
