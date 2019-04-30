class AddPolymorphicAssociationToMemberships < ActiveRecord::Migration
  def change
    rename_column :memberships, :team_id, :membershipable_id
    add_column :memberships, :membershipable_type, :string

    add_index :memberships, [:membershipable_id, :membershipable_type]
  end
end
