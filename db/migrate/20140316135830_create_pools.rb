class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.string :name
      t.boolean :public
      t.string :image
      t.string :password

      t.timestamps
    end
  end
end
