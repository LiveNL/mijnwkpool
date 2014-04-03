class AddDigestToPools < ActiveRecord::Migration
  def change
    add_column :pools, :password_digest, :string
  end
end
