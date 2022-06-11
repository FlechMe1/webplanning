class AddIsPublicToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :is_public, :boolean
  end
end
