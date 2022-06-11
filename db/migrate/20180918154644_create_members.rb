class CreateMembers < ActiveRecord::Migration[4.2]
  def change
    create_table :members do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :address_1
      t.string :address_2
      t.string :zipcode
      t.string :town
      t.string :phone_1
      t.string :phone_2
      t.references :user

      t.timestamps null: false
    end
  end
end
