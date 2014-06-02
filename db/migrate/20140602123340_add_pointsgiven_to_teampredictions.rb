class AddPointsgivenToTeampredictions < ActiveRecord::Migration
  def change
    add_column :teampredictions, :pointsgiven, :integer, :default => 0
  end
end
