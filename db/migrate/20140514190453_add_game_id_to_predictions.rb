class AddGameIdToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :game_id, :integer
  end
end
