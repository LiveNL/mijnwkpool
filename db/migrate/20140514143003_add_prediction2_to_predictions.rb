class AddPrediction2ToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :prediction2, :integer
  end
end
