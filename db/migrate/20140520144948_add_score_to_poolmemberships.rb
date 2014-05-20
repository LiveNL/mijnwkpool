class AddScoreToPoolmemberships < ActiveRecord::Migration
  def change
    add_column :poolmemberships, :score, :integer, :default => 0
  end
end
