class AddAssociationToMembers < ActiveRecord::Migration
  def change
    add_reference :members, :association
  end
end
