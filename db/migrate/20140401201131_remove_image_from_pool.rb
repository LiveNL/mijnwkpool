class RemoveImageFromPool < ActiveRecord::Migration
  def change
    remove_column :pools, :image, :string
  end
end
