class AddGenderToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :gender, :string
  end
end
