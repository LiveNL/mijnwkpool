class FixTeamcolumnName3 < ActiveRecord::Migration
  def change
    rename_column :games, :team1, :team1_id
  end
end
