class FixTeamcolumnName < ActiveRecord::Migration
  def change
    rename_column :predictions, :team1, :team1_id
  end
end
