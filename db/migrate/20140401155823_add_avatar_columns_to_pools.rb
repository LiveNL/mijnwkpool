class AddAvatarColumnsToPools < ActiveRecord::Migration
  def self.up
    add_attachment :pools, :avatar
  end

  def self.down
    remove_attachment :pools, :avatar
  end
end