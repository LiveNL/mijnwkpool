class UpdateDefaultMaxMembershipToPool < ActiveRecord::Migration
  def change
    change_column :pools, :maximum_membership, :int, default: 0
  end
end
