class AddBooleanToCompleted < ActiveRecord::Migration
  def up
		change_column :games, :completed, :boolean, :default => false
  end
end
