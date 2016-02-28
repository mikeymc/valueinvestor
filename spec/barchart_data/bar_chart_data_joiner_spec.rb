require 'rails_helper'

RSpec.describe BarChartDataJoiner do
  before(:each) do
    create(:stock, symbol: 'AAPL')
  end

  it 'returns data for a stock from the MarketWatch analyst estimates page' do
    data = {
      average_recommendation: '40% Sell'
    }
    BarChartDataJoiner.new.join('AAPL', data)
    expect(Stock.find_by_symbol('AAPL').bar_chart_data.average_recommendation).to eq('40% Sell')
  end

  it 'does nothing when the response is nil' do
    BarChartDataJoiner.new.join('AAPL', nil)
    expect(Stock.find_by_symbol('AAPL').bar_chart_data).to be_nil
  end
end
