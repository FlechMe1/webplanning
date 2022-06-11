class AddCategoryToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :category, :string, default: :contact
  end
end
