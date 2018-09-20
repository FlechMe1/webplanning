class AddCguToMembers < ActiveRecord::Migration
  def change
    add_column :members, :cgu, :boolean
  end
end
