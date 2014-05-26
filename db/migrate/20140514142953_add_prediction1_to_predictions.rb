class AddPrediction1ToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :prediction1, :integer
  end
end
