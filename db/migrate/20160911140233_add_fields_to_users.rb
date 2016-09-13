class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :birthdate, :date
    remove_column :users, :name
  end
end
