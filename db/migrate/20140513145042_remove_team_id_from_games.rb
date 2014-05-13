class RemoveTeamIdFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :team_id, :integer
  end
end
