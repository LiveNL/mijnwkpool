class AddPouleToGames < ActiveRecord::Migration
  def change
    add_column :games, :poule, :string
  end
end
