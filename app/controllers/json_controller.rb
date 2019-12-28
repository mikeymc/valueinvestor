class JsonController < ApplicationController
  def index
    render(json: get_stocks)
  end

  def get_stocks
    Stock.includes(:yahoo_data).includes(:yahoo_key_statistics_data)
  end
end
