class RemoveCountry2IdFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :country2_id, :integer
  end
end
