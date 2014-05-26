class RemoveScore1FromPredictions < ActiveRecord::Migration
  def change
    remove_column :predictions, :score1, :integer
  end
end
