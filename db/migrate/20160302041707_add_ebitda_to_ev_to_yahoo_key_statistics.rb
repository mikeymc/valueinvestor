class AddEbitdaToEvToYahooKeyStatistics < ActiveRecord::Migration
  def change
    add_column :yahoo_key_statistics_data, :ebitda_to_ev, :decimal
  end
end
