class AddTokenToMembers < ActiveRecord::Migration
  def change
    add_column :members, :token, :string, unique: true
  end
end
