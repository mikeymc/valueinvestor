require 'rails_helper'

RSpec.describe YahooKeyStatisticsDataJoiner do
  it 'returns data for a stock from the MarketWatch analyst estimates page' do
    create(:stock, symbol: 'AAPL', yahoo_data: create(:yahoo_data, ebitda: 280965000000))
    data = {
      enterprise_value: 561930000000,
      profit_margin: 22.87,
      operating_margin: 30.28,
      return_on_assets: 16.02,
      return_on_equity: 42.71,
      beta: 1.35
    }
    YahooKeyStatisticsDataJoiner.new.join('AAPL', data)
    yahoo_stock = Stock.find_by_symbol('AAPL')
    expect(yahoo_stock.yahoo_key_statistics_data.enterprise_value).to eq(561930000000)
    expect(yahoo_stock.yahoo_key_statistics_data.profit_margin).to eq(22.87)
    expect(yahoo_stock.yahoo_key_statistics_data.operating_margin).to eq(30.28)
    expect(yahoo_stock.yahoo_key_statistics_data.return_on_assets).to eq(16.02)
    expect(yahoo_stock.yahoo_key_statistics_data.return_on_equity).to eq(42.71)
    expect(yahoo_stock.yahoo_key_statistics_data.ebitda_to_ev).to eq(0.5)
    expect(yahoo_stock.yahoo_key_statistics_data.beta).to eq(1.35)
  end

  describe 'when ev is nil' do
    it 'does not set ebitda_to_ev' do
      create(:stock, symbol: 'AAPL', yahoo_data: create(:yahoo_data, ebitda: 280965000000))
      data = {
        profit_margin: 22.87,
        operating_margin: 30.28,
        return_on_assets: 16.02,
        return_on_equity: 42.71,
        beta: 1.35
      }
      YahooKeyStatisticsDataJoiner.new.join('AAPL', data)
      yahoo_stock = Stock.find_by_symbol('AAPL')
      expect(yahoo_stock.yahoo_key_statistics_data.ebitda_to_ev).to eq(nil)
    end
  end

  describe 'when ebitda is nil' do
    it 'does not set ebitda_to_ev' do
      create(:stock, symbol: 'AAPL', yahoo_data: create(:yahoo_data, ebitda: nil))
      data = {
        enterprise_value: 561930000000,
        profit_margin: 22.87,
        operating_margin: 30.28,
        return_on_assets: 16.02,
        return_on_equity: 42.71,
        beta: 1.35
      }
      YahooKeyStatisticsDataJoiner.new.join('AAPL', data)
      yahoo_stock = Stock.find_by_symbol('AAPL')
      expect(yahoo_stock.yahoo_key_statistics_data.ebitda_to_ev).to eq(nil)
    end
  end

  it 'does nothing when the response is nil' do
    create(:stock, symbol: 'AAPL', yahoo_data: create(:yahoo_data, ebitda: 280965000000))
    YahooKeyStatisticsDataJoiner.new.join('AAPL', nil)
    yahoo_stock = Stock.find_by_symbol('AAPL')
    expect(yahoo_stock.yahoo_key_statistics_data).to be_nil
  end
end
