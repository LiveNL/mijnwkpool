class AddPointsearnedToPrediction < ActiveRecord::Migration
  def change
    add_column :predictions, :pointsearned, :integer, :default => 0
  end
end
