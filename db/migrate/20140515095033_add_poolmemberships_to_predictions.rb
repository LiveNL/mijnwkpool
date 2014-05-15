class AddPoolmembershipsToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :poolmembership_id, :integer
  end
end
