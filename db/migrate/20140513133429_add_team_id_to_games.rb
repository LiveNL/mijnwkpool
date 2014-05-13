class AddTeamIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :team_id, :string
  end
end
