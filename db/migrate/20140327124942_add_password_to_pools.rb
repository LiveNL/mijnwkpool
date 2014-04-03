class AddPasswordToPools < ActiveRecord::Migration
  def change
    add_column :pools, :password_hash, :string
    add_column :pools, :password_salt, :string
  end
end
