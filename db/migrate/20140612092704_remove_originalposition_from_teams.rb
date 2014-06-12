class RemoveOriginalpositionFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :originalposition, :integer
  end
end
