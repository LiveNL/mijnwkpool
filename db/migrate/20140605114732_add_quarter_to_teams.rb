class AddQuarterToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :quarter, :boolean, :default => false
  end
end
