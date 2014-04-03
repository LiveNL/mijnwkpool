class AddAttachmentAvatarToPools < ActiveRecord::Migration
  def self.up
    change_table :pools do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :pools, :avatar
  end
end
