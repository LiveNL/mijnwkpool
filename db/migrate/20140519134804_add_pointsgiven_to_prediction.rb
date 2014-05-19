class AddPointsgivenToPrediction < ActiveRecord::Migration
  def change
    add_column :predictions, :pointsgiven, :integer, :default => 0
  end
end
