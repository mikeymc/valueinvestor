class AddDividendYieldToYahooData < ActiveRecord::Migration
  def change
    add_column :yahoo_data, :dividend_yield, :decimal
  end
end
