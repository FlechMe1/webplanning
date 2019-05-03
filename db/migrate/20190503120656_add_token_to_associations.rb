class AddTokenToAssociations < ActiveRecord::Migration
  def change
    add_column :associations, :token, :string
  end
end
