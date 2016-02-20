class ChangeNumericStringsToDecimals < ActiveRecord::Migration
  def change
    change_column :stocks, :current_eps,  :decimal
    change_column :stocks, :dividends_per_share,  :decimal
    change_column :stocks, :day_high_price,  :decimal
    change_column :stocks, :day_low_price,  :decimal
    change_column :stocks, :book_value,  :decimal
    change_column :stocks, :price_to_book_ratio,  :decimal
    change_column :stocks, :price_to_earnings_ratio,  :decimal
    change_column :stocks, :year_low_price,  :decimal
    change_column :stocks, :year_high_price,  :decimal
  end
end
