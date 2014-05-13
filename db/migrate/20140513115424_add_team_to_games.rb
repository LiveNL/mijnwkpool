class AddTeamToGames < ActiveRecord::Migration
  def change
    add_column :games, :team1, :integer
    add_column :games, :team2, :integer
  end
end
