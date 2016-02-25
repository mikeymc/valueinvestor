require 'rails_helper'

RSpec.describe ListInitializer do
  describe 'intialize_nasdaq_list' do
    it 'constructs a complete list of Nasdaq stocks' do
      @initializer = ListInitializer.new
      @initializer.initialize_nasdaq_list

      @stocks = Stock.all
      expect(@stocks.size).to eq(3087)
      expect(@stocks.first.symbol).to eq('TFSC')
      expect(@stocks.first.name).to eq('1347 CAPITAL CORP.')

      @stocks.each do |stock|
        expect(stock.exchange).to eq('Nasdaq')
      end
    end
  end

  describe 'intialize_nyse_list' do
    it 'constructs a complete list of NYSE stocks' do
      @initializer = ListInitializer.new
      @initializer.initialize_nyse_list

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
