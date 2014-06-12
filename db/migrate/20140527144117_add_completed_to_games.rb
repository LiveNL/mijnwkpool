class AddCompletedToGames < ActiveRecord::Migration
  def change
    add_column :games, :completed, :boolean
  end
end
