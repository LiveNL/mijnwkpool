class AddOriginalpositionToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :original_position, :integer
  end
end
