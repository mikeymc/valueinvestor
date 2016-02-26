class AddMoreFieldsToYahooStock < ActiveRecord::Migration
  def change
    add_column :yahoo_data, :ebitda, :string
    add_column :yahoo_data, :market_cap, :string
    add_column :yahoo_data, :one_year_target_price, :decimal
    add_column :yahoo_data, :fifty_day_moving_average, :decimal
    add_column :yahoo_data, :percent_change_from_fifty_day_moving_average, :decimal
    add_column :yahoo_data, :two_hundred_day_moving_average, :decimal
    add_column :yahoo_data, :percent_change_from_two_hundred_day_moving_average, :decimal
  end
end
