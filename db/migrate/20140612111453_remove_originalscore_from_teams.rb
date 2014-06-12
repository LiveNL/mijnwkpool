class RemoveOriginalscoreFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :originalscore, :integer
  end
end
