class AddTokenToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :token, :string, unique: true
  end
end
