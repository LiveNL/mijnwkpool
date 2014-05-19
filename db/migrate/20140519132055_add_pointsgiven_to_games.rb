class AddPointsgivenToGames < ActiveRecord::Migration
  def change
    add_column :games, :pointsgiven, :integer, :default => 0
  end
end
