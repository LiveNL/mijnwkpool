class RemoveTeamsFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :team1_id, :integer
    remove_column :games, :team2_id, :integer
  end
end
