class AddScoreToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :score1, :integer
    add_column :predictions, :score2, :integer
  end
end
