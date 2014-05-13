class RemoveCountry1IdFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :country1_id, :integer
  end
end
