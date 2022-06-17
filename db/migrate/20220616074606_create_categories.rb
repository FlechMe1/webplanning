class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :structure, foreign_key: true

      t.timestamps
    end

    create_table :categorizations do |t|
      t.references :category
      t.references :categorizable, polymorphic: true, index: true

      t.timestamps
    end

    remove_column :members, :category
  end
end
