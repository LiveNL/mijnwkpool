class AddColumnsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :name, :string
    add_column :teams, :poule, :string
    add_column :teams, :avatar_file_name, :string
    add_column :teams, :avatar_content_type, :string
    add_column :teams, :avatar_file_size, :integer
    add_column :teams, :avatar_updated_at, :datetime
  end
end
