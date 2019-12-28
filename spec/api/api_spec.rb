require 'rails_helper'

describe('#index') do
  it 'returns a 200' do
    get '/json'
    expect(response.status).to eq(200)
  end

  describe 'the json response' do
    before(:each) do
      @stock_1 = Stock.new(id: 1)
      @stock_2 = Stock.new(id: 2)
      @stock_3 = Stock.new(id: 3)
      @stocks = [@stock_1, @stock_2, @stock_3]

      allow_any_instance_of(JsonController).to receive(:get_stocks).and_return(@stocks)
    end
    
    it 'has the right number of stocks' do
      get '/json'
      body = JSON.parse(response.body)
   
      expect(body.length).to eq(3)
      expect(body[0]['id']).to eq(1)
      expect(body[1]['id']).to eq(2)
      expect(body[2]['id']).to eq(3)
    end
  end
end
