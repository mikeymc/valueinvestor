class AddYearHighAndLowToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :year_low_price, :string
    add_column :stocks, :year_high_price, :string
  end
end
