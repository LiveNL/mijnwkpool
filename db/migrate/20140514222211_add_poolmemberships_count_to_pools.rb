class AddPoolmembershipsCountToPools < ActiveRecord::Migration
  def change
    add_column :pools, :poolmemberships_count, :int, default: 0

    Pool.reset_column_information

    Pool.all.each do |p|
      Pool.update p.id, poolmemberships_count: p.poolmemberships.length
    end
  end
end
