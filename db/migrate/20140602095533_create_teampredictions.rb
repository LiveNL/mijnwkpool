class CreateTeampredictions < ActiveRecord::Migration
  def change
    create_table :teampredictions do |t|
      t.integer :pouleposition
      t.integer :team_id
      t.integer :poolmembership_id

      t.timestamps
    end
  end
end
