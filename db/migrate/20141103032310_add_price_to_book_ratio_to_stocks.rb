class AddPriceToBookRatioToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :price_to_book_ratio, :string
  end
end
