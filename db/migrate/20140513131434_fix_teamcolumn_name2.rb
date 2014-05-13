class FixTeamcolumnName2 < ActiveRecord::Migration
  def change
    rename_column :predictions, :team2, :team2_id
  end
end
