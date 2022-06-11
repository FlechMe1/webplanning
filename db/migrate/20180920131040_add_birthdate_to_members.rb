class AddBirthdateToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :birthdate, :date
    remove_column :users, :birthdate
  end
end
