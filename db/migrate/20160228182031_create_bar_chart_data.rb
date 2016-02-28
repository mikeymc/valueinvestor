class CreateBarChartData < ActiveRecord::Migration
  def change
    create_table :bar_chart_data do |t|
      t.string :average_recommendation
      t.timestamps
    end
    add_reference :bar_chart_data, :stock, index: true
  end
end
