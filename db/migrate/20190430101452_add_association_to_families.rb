class AddAssociationToFamilies < ActiveRecord::Migration
  def change
    add_reference :families, :association
  end
end
