class AddOriginalpositionToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :originalposition, :integer
  end
end
