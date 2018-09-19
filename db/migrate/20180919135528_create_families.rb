class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :zipcode
      t.string :town
      t.string :phone_1
      t.string :phoness_2
      t.string :email

      t.timestamps null: false
    end
  end
end
