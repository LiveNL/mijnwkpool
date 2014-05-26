class RenameTypeFromGames < ActiveRecord::Migration
  def change
    rename_column :games, :type, :gametype
  end
end
