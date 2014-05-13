class AddTeamId1ToGames < ActiveRecord::Migration
  def change
    add_column :games, :team_id1, :integer
  end
end
