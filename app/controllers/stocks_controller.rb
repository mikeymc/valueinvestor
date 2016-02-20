class StocksController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @stocks = Stock
                .where.not(sort_column.to_sym => '')
                .order(sort_column + ' ' + sort_direction)
                .paginate(:page => params[:page], :per_page => 30)
  end

  def sort_column
    Stock.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
