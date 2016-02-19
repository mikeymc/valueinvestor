class RenameCurrentEpsToCurrentEps < ActiveRecord::Migration
  def change
    rename_column :stocks, :currentEPS, :current_eps
  end
end
