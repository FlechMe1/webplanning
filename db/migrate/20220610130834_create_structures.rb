class CreateStructures < ActiveRecord::Migration[6.1]
  def change
    create_table :structures do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :zipcode
      t.string :town
      t.string :website
      t.string :phone

      t.string :token

      t.timestamps
    end

    add_reference :events, :structure
    add_reference :teams, :structure
    add_reference :families, :structure
    add_reference :members, :structure

    create_table :structures_users do |t|
      t.references :structure
      t.references :user

      t.timestamps
    end
  end
end
