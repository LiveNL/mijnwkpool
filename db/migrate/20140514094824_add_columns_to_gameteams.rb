class AddColumnsToGameteams < ActiveRecord::Migration
  def change
    add_column :gameteams, :game_id, :integer
    add_column :gameteams, :team1_id, :integer
    add_column :gameteams, :team2_id, :integer
  end
end
