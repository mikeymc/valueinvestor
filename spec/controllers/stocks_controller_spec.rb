require 'rails_helper'

RSpec.describe StocksController, :type => :controller do
   describe 'index' do
     it 'should generate the symbol list, call out to the api, populate the stocks, and render the index page' do
       'A'.upto('Z') do |symbol|
         create(:stock, symbol: symbol)
       end

       get :index
       expect(response.status).to eq 200
       expect(response).to render_template(:index)

       rendered_stocks = assigns(:stocks)
       expect(rendered_stocks.size).to eq(26)
     end
   end
end
