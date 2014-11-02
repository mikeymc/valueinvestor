class AddDayHighPriceToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :day_high_price, :string
  end
end
