class AddDayLowPriceToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :day_low_price, :string
  end
end
