class CreatePoolmemberships < ActiveRecord::Migration
  def change
    create_table :poolmemberships do |t|
      t.integer :user_id
      t.integer :pool_id
      t.integer :role

      t.timestamps
    end
  end
end
