class CreateAssignments < ActiveRecord::Migration[4.2]
  def change
    create_table :assignments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
