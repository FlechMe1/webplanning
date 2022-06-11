class AddCguToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :cgu, :boolean
  end
end
