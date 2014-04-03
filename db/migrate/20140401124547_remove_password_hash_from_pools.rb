class RemovePasswordHashFromPools < ActiveRecord::Migration
  def change
    remove_column :pools, :password_hash, :string
  end
end
