class CreateEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.string :label
      t.datetime :begin_at
      t.datetime :end_at
      t.text :description
      t.string :organizer_type
      t.integer :organizer_id

      t.timestamps null: false
    end
    add_index :events, [:organizer_id, :organizer_type]
  end
end
