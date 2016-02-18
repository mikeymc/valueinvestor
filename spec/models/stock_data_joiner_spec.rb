require 'rails_helper'

RSpec.describe StockDataJoiner do
  it 'merges the Yahoo data into the stocks' do
    create(:stock, symbol: 'TIF', name: 'Buffalo Wild Wings', exchange: 'NYSE')
    create(:stock, symbol: 'RGDX', name: 'The Gap', exchange: 'Nasdaq')

    first_stock = {}
    first_stock[:name] = 'Buffalo Wild Wings'
    first_stock[:symbol] = 'TIF'
    first_stock[:exchange] = 'NYSE'
    first_stock[:currentEPS] = '3.78'
    first_stock[:dividends_per_share] = '1.60'
    first_stock[:day_high_price] = '61.91'
    first_stock[:day_low_price] = '60.43'
    first_stock[:book_value] = '22.25'
    first_stock[:price_to_book_ratio] = '2.73'

    second_stock = {}
    second_stock[:name] = 'The Gap'
    second_stock[:symbol] = 'RGDX'
    second_stock[:exchange] = 'NCM'
    second_stock[:currentEPS] = '-0.190'
    second_stock[:dividends_per_share] = 'N/A'
    second_stock[:day_high_price] = 'N/A'
    second_stock[:day_low_price] = 'N/A'
    second_stock[:book_value] = '0.000'
    second_stock[:price_to_book_ratio] = 'N/A'

    stock_data_from_yahoo = [first_stock, second_stock]

    @joiner = StockDataJoiner.new
    @joiner.join(stock_data_from_yahoo)

    tif_stock = Stock.find_by_symbol('TIF')
    rgdx_stock = Stock.find_by_symbol('RGDX')

    expect(tif_stock[:name]).to eq('Buffalo Wild Wings')
    expect(tif_stock[:symbol]).to eq('TIF')
    expect(tif_stock[:exchange]).to eq('NYSE')
    expect(tif_stock[:currentEPS]).to eq('3.78')
    expect(tif_stock[:dividends_per_share]).to eq('1.60')
    expect(tif_stock[:day_high_price]).to eq('61.91')
    expect(tif_stock[:day_low_price]).to eq('60.43')
    expect(tif_stock[:book_value]).to eq('22.25')
    expect(tif_stock[:price_to_book_ratio]).to eq('2.73')

    expect(rgdx_stock[:name]).to eq('The Gap')
    expect(rgdx_stock[:symbol]).to eq('RGDX')
    expect(rgdx_stock[:exchange]).to eq('Nasdaq')
    expect(rgdx_stock[:currentEPS]).to eq('-0.190')
    expect(rgdx_stock[:dividends_per_share]).to eq('N/A')
    expect(rgdx_stock[:day_high_price]).to eq('N/A')
    expect(rgdx_stock[:day_low_price]).to eq('N/A')
    expect(rgdx_stock[:book_value]).to eq('0.000')
    expect(rgdx_stock[:price_to_book_ratio]).to eq('N/A')
  end
end
