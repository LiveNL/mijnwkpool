class AddTeampointsearnedToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :teampointsearned, :integer, :default => 0
  end
end
