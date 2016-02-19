class AddPriceToEarningsRatioToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :price_to_earnings_ratio, :string
  end
end
