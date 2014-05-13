class AddTeamToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :team1, :integer
    add_column :predictions, :team2, :integer
  end
end
