require 'rails_helper'

RSpec.describe YahooStockDataFetcher do
  it 'returns data given a list of ticker symbols' do
    fake_response = "\"Tiffany & Co. Common Stock\",\"TIF\",\"NYQ\",3.78,1.60,61.91,60.43,22.25,2.73\n\"Response Genetics, Inc.\",\"RGDX\",\"NCM\",-0.190,N/A,N/A,N/A,0.000,N/A"

    WebMock
      .stub_request(:get, 'http://download.finance.yahoo.com/d/quotes.csv?f=nsxe7dhgb4p6&s=TIF%2BRGDX')
      .to_return(status: 200, body: fake_response, headers: {})

    @fetcher = YahooStockDataFetcher.new
    data = @fetcher.fetch_stock_data(['TIF', 'RGDX'])

    first_stock = data[0]
    expect(first_stock[:name]).to eq('Tiffany & Co. Common Stock')
    expect(first_stock[:symbol]).to eq('TIF')
    expect(first_stock[:index]).to eq('NYQ')
    expect { Float(first_stock[:currentEPS]) }.not_to raise_error
    expect { Float(first_stock[:dividends_per_share]) }.not_to raise_error
    expect { Float(first_stock[:day_high_price]) }.not_to raise_error
    expect { Float(first_stock[:day_low_price]) }.not_to raise_error
    expect { Float(first_stock[:book_value]) }.not_to raise_error
    expect { Float(first_stock[:price_to_book_ratio]) }.not_to raise_error

    second_stock = data[1]
    expect(second_stock[:name]).to eq('Response Genetics, Inc.')
    expect(second_stock[:symbol]).to eq('RGDX')
    expect(second_stock[:index]).to eq('NCM')
    expect(second_stock[:currentEPS]).to eq('-0.190')
    expect(second_stock[:dividends_per_share]).to eq('N/A')
    expect(second_stock[:day_high_price]).to eq('N/A')
    expect(second_stock[:day_low_price]).to eq('N/A')
    expect(second_stock[:book_value]).to eq('0.000')
    expect(second_stock[:price_to_book_ratio]).to eq('N/A')
  end
end
