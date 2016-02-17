require 'net/http'

class StocksController < ApplicationController
  def index
    @stocks = Stock.paginate(:page => params[:page], :per_page => 30)
  end
end
