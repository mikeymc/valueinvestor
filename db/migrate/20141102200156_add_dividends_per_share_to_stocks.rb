class AddDividendsPerShareToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :dividends_per_share, :string
  end
end
