class AddFinalToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :final, :integer
  end
end
