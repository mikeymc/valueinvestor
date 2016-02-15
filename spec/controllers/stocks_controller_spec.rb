require 'rails_helper'

RSpec.describe StocksController, :type => :controller do
   describe 'index' do
     raw_response = "\"Exxon Mobil Corpo\",\"XOM\",\"NYSE\",7.58,1.11,2.22,3.33,5.432,22\r\n\"Apple Inc.\",\"AAPL\",\"NasdaqNM\",7.65,4.44,5.55,6.66,7.777,55\r\n"
     before(:each) do
       Stock.delete_all
       stub_request(:get, /./).
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => raw_response, :headers => {})
       stub_request(:get, "http://download.finance.yahoo.com/d/quotes.csv?s=XOM%20AAPL&f=nsxe7").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => raw_response, :headers => {})
     end
     it 'should generate the symbol list, call out to the api, populate the stocks, and return them' do
       expect(Stock.all.size).to eq(0)
       expect_any_instance_of(QuerySetup).to receive(:generate_list).once.and_call_original
       expect_any_instance_of(QuerySetup).to receive(:get_next_200).exactly(75).times.and_call_original
       expect_any_instance_of(QuerySetup).to receive(:make_request).exactly(75).times.and_call_original
       get :index
       expect(Stock.all.size).to eq(150)
       aapl = Stock.find_by_symbol('AAPL')
       expect(aapl.name).to eq('Apple Inc.')
       expect(aapl.symbol).to eq('AAPL')
       expect(aapl.index).to eq('NasdaqNM')
       expect(aapl.currentEPS).to eq('7.65')
       expect(aapl.dividends_per_share).to eq('4.44')
       expect(aapl.day_high_price).to eq('5.55')
       expect(aapl.day_low_price).to eq('6.66')
       expect(aapl.book_value).to eq('7.777')
       expect(aapl.price_to_book_ratio).to eq('55')
       expect(Stock.find_by_symbol('XOM').name).to eq('Exxon Mobil Corpo')
       expect(response.status).to eq 200
     end
   end
end
