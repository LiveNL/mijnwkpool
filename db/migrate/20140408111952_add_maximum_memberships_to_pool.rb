class AddMaximumMembershipsToPool < ActiveRecord::Migration
  def change
    add_column :pools, :maximum_membership, :int
  end
end
