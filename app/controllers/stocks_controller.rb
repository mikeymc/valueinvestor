class StocksController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @stocks = Stock
                .includes(:yahoo_data)
                .includes(:yahoo_key_statistics_data)
                .where.not(sort_column.to_sym => '')
                .order(sort_column + ' ' + sort_direction)
                .paginate(:page => params[:page], :per_page => 20)

    @stocks = @stocks.yield_above(params[:dividend_yield_filter]) if params[:dividend_yield_filter]
    @stocks = @stocks.price_to_earnings_below(params[:price_to_earnings_maximum]) if params[:price_to_earnings_maximum]
    @stocks = @stocks.profit_margin_at_least(params[:minimum_profit_margin]) if params[:minimum_profit_margin]
  end

  def sort_column
    params[:sort] ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
