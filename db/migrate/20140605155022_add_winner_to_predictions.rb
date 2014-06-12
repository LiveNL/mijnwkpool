class AddWinnerToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :winner, :integer
  end
end
