class MoveExistingYahooColumnsToItsOwnTable < ActiveRecord::Migration
  def change
    remove_column :stocks, :current_eps
    remove_column :stocks, :dividends_per_share
    remove_column :stocks, :day_high_price
    remove_column :stocks, :day_low_price
    remove_column :stocks, :book_value
    remove_column :stocks, :price_to_book_ratio
    remove_column :stocks, :price_to_earnings_ratio
    remove_column :stocks, :year_low_price
    remove_column :stocks, :year_high_price

    create_table :yahoo_data do |t|
      t.decimal :current_eps
      t.decimal :dividends_per_share
      t.decimal :day_high_price
      t.decimal :day_low_price
      t.decimal :book_value
      t.decimal :price_to_book_ratio
      t.decimal :price_to_earnings_ratio
      t.decimal :year_low_price
      t.decimal :year_high_price
    end

    add_reference :yahoo_data, :stock, index: true
  end
end
