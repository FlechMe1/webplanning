class CreateSiblings < ActiveRecord::Migration[4.2]
  def change
    create_table :siblings do |t|
      t.references :member, index: true, foreign_key: true
      t.references :family, index: true, foreign_key: true
      t.string :status

      t.timestamps null: false
    end
  end
end
