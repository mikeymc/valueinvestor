class StocksController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @stocks = Stock
                .includes(:yahoo_data)
                .includes(:yahoo_key_statistics_data)
                .where.not(sort_column => nil)
                .order(sort_column + ' ' + sort_direction)
                .paginate(:page => params[:page], :per_page => 20)

    @stocks = @stocks.yield_above(params[:dividend_yield_filter]) unless params[:dividend_yield_filter].blank?
    @stocks = @stocks.price_to_earnings_below(params[:price_to_earnings_maximum]) unless params[:price_to_earnings_maximum].blank?
    @stocks = @stocks.profit_margin_at_least(params[:minimum_profit_margin]) unless params[:minimum_profit_margin].blank?
    @stocks = @stocks.operating_margin_at_least(params[:minimum_operating_margin]) unless params[:minimum_operating_margin].blank?
    @stocks = @stocks.one_year_target_growth_rate_at_least(params[:one_year_target_growth_rate]) unless params[:one_year_target_growth_rate].blank?
    @stocks = @stocks.search_by_name(params[:stock_name_search_parameter].upcase) unless params[:stock_name_search_parameter].blank?
  end

  def sort_column
    params[:sort] ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
