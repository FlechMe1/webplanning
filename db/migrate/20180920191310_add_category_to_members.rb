class AddCategoryToMembers < ActiveRecord::Migration
  def change
    add_column :members, :category, :string, default: :contact
  end
end
