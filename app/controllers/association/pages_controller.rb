class Association::PagesController < AssociationController

  def home
    @families = @association.families.count
    @members = @association.members.count
    @volunteers = @association.users.count
    @teams = @association.teams.count
  end

end
