class AddBookValueToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :book_value, :string
  end
end
