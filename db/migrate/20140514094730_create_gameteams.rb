class CreateGameteams < ActiveRecord::Migration
  def change
    create_table :gameteams do |t|

      t.timestamps
    end
  end
end
