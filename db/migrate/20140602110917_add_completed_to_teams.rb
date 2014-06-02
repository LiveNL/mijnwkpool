class AddCompletedToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :completed, :boolean, :default => false
  end
end
