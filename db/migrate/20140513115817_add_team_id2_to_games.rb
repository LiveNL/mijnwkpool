class AddTeamId2ToGames < ActiveRecord::Migration
  def change
    add_column :games, :team_id2, :integer
  end
end
