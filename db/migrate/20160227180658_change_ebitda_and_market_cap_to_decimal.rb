class ChangeEbitdaAndMarketCapToDecimal < ActiveRecord::Migration
  def change
    change_column :yahoo_data, :ebitda, :decimal
    change_column :yahoo_data, :market_cap, :decimal
  end
end
