class RemovePasswordFromPools < ActiveRecord::Migration
  def change
    remove_column :pools, :password, :string
  end
end
