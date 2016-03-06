class RecreateAllTables < ActiveRecord::Migration
  def change
    create_table :stocks do |s|
      s.string :name
      s.string :symbol
      s.string :exchange
    end
    create_table :market_watch_data do |s|
      s.string :average_recommendation
    end
    create_table :street_insider_data do |s|
      s.string :average_recommendation
    end
    create_table :bar_chart_data do |s|
      s.string :average_recommendation
    end
    create_table :yahoo_data do |s|
      s.decimal :current_eps
      s.decimal :dividends_per_share
      s.decimal :day_high_price
      s.decimal :day_low_price
      s.decimal :book_value
      s.decimal :price_to_book_ratio
      s.decimal :price_to_earnings_ratio
      s.decimal :year_low_price
      s.decimal :year_high_price
      s.decimal :ebitda
      s.decimal :market_cap
      s.decimal :one_year_target_price
      s.decimal :fifty_day_moving_average
      s.decimal :percent_change_from_fifty_day_moving_average
      s.decimal :two_hundred_day_moving_average
      s.decimal :percent_change_from_two_hundred_day_moving_average
      s.decimal :last_trade_price
      s.decimal :dividend_yield
      s.decimal :one_year_growth_expectation
    end
    create_table :yahoo_key_statistics_data do |s|
      s.decimal :enterprise_value
      s.decimal :profit_margin
      s.decimal :operating_margin
      s.decimal :return_on_assets
      s.decimal :return_on_equity
      s.decimal :beta
      s.decimal :ebitda_to_ev
    end

    add_reference :market_watch_data, :stock, index: true
    add_reference :yahoo_data, :stock, index: true
    add_reference :yahoo_key_statistics_data, :stock, index: true
    add_reference :bar_chart_data, :stock, index: true
    add_reference :street_insider_data, :stock, index: true
  end
end
