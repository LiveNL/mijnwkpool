class FixTeamcolumnName4 < ActiveRecord::Migration
  def change
    rename_column :games, :team2, :team2_id
  end
end
