class AddColumnsToGames < ActiveRecord::Migration
  def change
    add_column :games, :type, :string
    add_column :games, :date, :date
    add_column :games, :time, :time
  end
end
