class AddScoreToGames < ActiveRecord::Migration
  def change
    add_column :games, :score1, :integer
    add_column :games, :score2, :integer
  end
end
