class AddOriginalscoreToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :originalscore, :integer
  end
end
