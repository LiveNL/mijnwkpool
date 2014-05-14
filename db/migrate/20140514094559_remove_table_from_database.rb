class RemoveTableFromDatabase < ActiveRecord::Migration
  def change
    drop_table :gameteams
  end
end
