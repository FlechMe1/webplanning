class AddAssociationToTeams < ActiveRecord::Migration
  def change
    add_reference :teams, :association
  end
end
