class RemoveQuarterFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :quarter, :boolean
  end
end
