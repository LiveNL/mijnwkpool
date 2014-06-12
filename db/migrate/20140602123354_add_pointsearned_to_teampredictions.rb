class AddPointsearnedToTeampredictions < ActiveRecord::Migration
  def change
    add_column :teampredictions, :pointsearned, :integer, :default => 0
  end
end
