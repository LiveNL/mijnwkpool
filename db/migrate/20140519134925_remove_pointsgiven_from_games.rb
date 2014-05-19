class RemovePointsgivenFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :pointsgiven, :integer
  end
end
