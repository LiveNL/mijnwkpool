class AddOriginalpositionToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :Originalposition, :integer
  end
end
