require 'rails_helper'

RSpec.describe YahooDataJoiner do
  it 'merges the Yahoo data into the stocks' do
    create(:stock, symbol: 'TIF', name: 'Buffalo Wild Wings', exchange: 'NYSE')
    create(:stock, symbol: 'RGDX', name: 'The Gap', exchange: 'Nasdaq')

    first_stock = {}
    first_stock[:name] = 'Buffalo Wild Wings'
    first_stock[:symbol] = 'TIF'
    first_stock[:exchange] = 'NYSE'
    first_stock[:current_eps] = 3.78
    first_stock[:dividends_per_share] = 1.6
    first_stock[:day_high_price] = 61.91
    first_stock[:day_low_price] = 60.43
    first_stock[:book_value] = 22.25
    first_stock[:price_to_book_ratio] = 2.73
    first_stock[:price_to_earnings_ratio] = 44.44
    first_stock[:year_low_price] = 100.11
    first_stock[:year_high_price] = 200.11

    second_stock = {}
    second_stock[:name] = 'The Gap'
    second_stock[:symbol] = 'RGDX'
    second_stock[:exchange] = 'NCM'
    second_stock[:current_eps] = -0.19
    second_stock[:dividends_per_share] = nil
    second_stock[:day_high_price] = nil
    second_stock[:day_low_price] = nil
    second_stock[:book_value] = 0.0
    second_stock[:price_to_book_ratio] = nil
    second_stock[:price_to_earnings_ratio] = nil
    second_stock[:year_low_price] = nil
    second_stock[:year_high_price] = nil

    stock_data_from_yahoo = [first_stock, second_stock]

    @joiner = YahooDataJoiner.new
    @joiner.join(stock_data_from_yahoo)

    tif_stock = Stock.find_by_symbol('TIF')
    rgdx_stock = Stock.find_by_symbol('RGDX')

    expect(tif_stock.name).to eq('Buffalo Wild Wings')
    expect(tif_stock.symbol).to eq('TIF')
    expect(tif_stock.exchange).to eq('NYSE')
    expect(tif_stock.yahoo_data.current_eps).to eq(3.78)
    expect(tif_stock.yahoo_data.dividends_per_share).to eq(1.6)
    expect(tif_stock.yahoo_data.day_high_price).to eq(61.91)
    expect(tif_stock.yahoo_data.day_low_price).to eq(60.43)
    expect(tif_stock.yahoo_data.book_value).to eq(22.25)
    expect(tif_stock.yahoo_data.price_to_book_ratio).to eq(2.73)
    expect(tif_stock.yahoo_data.price_to_earnings_ratio).to eq(44.44)
    expect(tif_stock.yahoo_data.year_low_price).to eq(100.11)
    expect(tif_stock.yahoo_data.year_high_price).to eq(200.11)

    expect(rgdx_stock.name).to eq('The Gap')
    expect(rgdx_stock.symbol).to eq('RGDX')
    expect(rgdx_stock.exchange).to eq('Nasdaq')
    expect(rgdx_stock.yahoo_data.current_eps).to eq(-0.19)
    expect(rgdx_stock.yahoo_data.dividends_per_share).to eq(nil)
    expect(rgdx_stock.yahoo_data.day_high_price).to eq(nil)
    expect(rgdx_stock.yahoo_data.day_low_price).to eq(nil)
    expect(rgdx_stock.yahoo_data.book_value).to eq(0.0)
    expect(rgdx_stock.yahoo_data.price_to_book_ratio).to eq(nil)
    expect(rgdx_stock.yahoo_data.price_to_earnings_ratio).to eq(nil)
    expect(rgdx_stock.yahoo_data.year_low_price).to eq(nil)
    expect(rgdx_stock.yahoo_data.year_high_price).to eq(nil)
  end
end
