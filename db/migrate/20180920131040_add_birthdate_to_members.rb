class AddBirthdateToMembers < ActiveRecord::Migration
  def change
    add_column :members, :birthdate, :date
    remove_column :users, :birthdate
  end
end
