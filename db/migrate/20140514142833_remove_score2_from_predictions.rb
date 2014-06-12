class RemoveScore2FromPredictions < ActiveRecord::Migration
  def change
    remove_column :predictions, :score2, :integer
  end
end
