class ChangeStockIndexToExchange < ActiveRecord::Migration
  def change
    rename_column :stocks, :index, :exchange
  end
end
