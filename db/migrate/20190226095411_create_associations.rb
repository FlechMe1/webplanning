class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :zipcode
      t.string :town
      t.string :email
      t.string :phone
      t.string :president_name
      t.string :dpo_name

      t.timestamps null: false
    end
  end
end
