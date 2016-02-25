class AddMarketWatchDataTable < ActiveRecord::Migration
  def change
    create_table :market_watch_data do |t|
      t.string :average_recommendation
      t.timestamps
    end
    add_reference :market_watch_data, :stock, index: true
  end
end
