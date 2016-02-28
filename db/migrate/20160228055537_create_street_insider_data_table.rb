class CreateStreetInsiderDataTable < ActiveRecord::Migration
  def change
    create_table :street_insider_data do |t|
      t.string :average_recommendation
      t.timestamps
    end
    add_reference :street_insider_data, :stock, index: true
  end
end
