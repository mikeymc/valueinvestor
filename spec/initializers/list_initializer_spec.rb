require 'rails_helper'

RSpec::Matchers.define :be_the_same_time_as do |expected|
  match do |actual|
    expect(expected.strftime('%d-%m-%Y %H:%M:%S')).to eq(actual.strftime('%d-%m-%Y %H:%M:%S'))
  end
end

RSpec.describe ListInitializer do
  describe 'refresh_nasdaq_stock_list' do
    it 'fetches the latest list of nasdaq stocks and saves it in a file' do
      @initializer = ListInitializer.new

      nasdaq_data = File.read('db/nasdaq.csv')

      WebMock
        .stub_request(:get, 'http://www.nasdaq.com/screening/companies-by-name.aspx?letter=0&exchange=nasdaq&render=download')
        .to_return(:status => 200, :body => nasdaq_data)

      @initializer.refresh_nasdaq_stock_list
      expect(File.mtime('db/nasdaq.csv')).to be_the_same_time_as Time.now
    end
  end

  describe 'refresh_nyse_stock_list' do
    it 'fetches the latest list of nyse stocks and saves it in a file' do
      @initializer = ListInitializer.new

      nyse_file = File.read('db/nyse.csv')

      WebMock
        .stub_request(:get, 'http://www.nasdaq.com/screening/companies-by-name.aspx?letter=0&exchange=nyse&render=download')
        .to_return(:status => 200, :body => nyse_file)

      @initializer.refresh_nyse_stock_list
      expect(File.mtime('db/nyse.csv')).to be_the_same_time_as Time.now
    end
  end

  describe 'load_nasdaq_list' do
    it 'constructs a complete list of Nasdaq stocks' do
      @initializer = ListInitializer.new
      @initializer.load_nasdaq_list

      @stocks = Stock.all
      expect(@stocks.size).to eq(3087)
      expect(@stocks.first.symbol).to eq('TFSC')
      expect(@stocks.first.name).to eq('1347 CAPITAL CORP.')

      @stocks.each do |stock|
        expect(stock.exchange).to eq('Nasdaq')
      end
    end
  end

  describe 'load_nyse_list' do
    it 'constructs a complete list of NYSE stocks' do
      @initializer = ListInitializer.new
      @initializer.load_nyse_list

      @stocks = Stock.all
      expect(@stocks.size).to eq(3239)
      expect(@stocks.first.symbol).to eq('DDD')
      expect(@stocks.first.name).to eq('3D SYSTEMS CORPORATION')

      @stocks.each do |stock|
        expect(stock.exchange).to eq('NYSE')
      end
    end
  end
end
