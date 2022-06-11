class AddColorToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :color, :string
  end
end
