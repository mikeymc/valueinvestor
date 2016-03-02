class AddOneYearGrowthExpectationToYahooData < ActiveRecord::Migration
  def change
    add_column :yahoo_data, :one_year_growth_expectation, :decimal
  end
end
