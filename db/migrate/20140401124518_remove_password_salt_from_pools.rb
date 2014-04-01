class RemovePasswordSaltFromPools < ActiveRecord::Migration
  def change
    remove_column :pools, :password_salt, :string
  end
end
