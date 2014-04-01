class RenamePublicToPools < ActiveRecord::Migration
  def change
    rename_column :pools, :public, :is_public
  end
end
