class AddFieldsToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :name, :string
    add_column :stocks, :index, :string
    add_column :stocks, :symbol, :string
    add_column :stocks, :currentEPS, :string
  end
end
