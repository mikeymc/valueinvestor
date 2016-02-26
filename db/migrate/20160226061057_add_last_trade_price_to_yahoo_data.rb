class AddLastTradePriceToYahooData < ActiveRecord::Migration
  def change
    add_column :yahoo_data, :last_trade_price, :decimal
  end
end
