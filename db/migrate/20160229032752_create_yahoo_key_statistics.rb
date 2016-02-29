class CreateYahooKeyStatistics < ActiveRecord::Migration
  def change
    create_table :yahoo_key_statistics_data do |t|
      t.decimal :enterprise_value
      t.decimal :profit_margin
      t.decimal :operating_margin
      t.decimal :return_on_assets
      t.decimal :return_on_equity
      t.decimal :beta
    end
    add_reference :yahoo_key_statistics_data, :stock, index: true
  end
end
