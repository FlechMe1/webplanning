class Association::PreviewController < AssociationController

  def index
    @families = @association.families.count
    @members = @association.members.count
    @volunteers = @association.users.count
    @teams = @association.teams.count
  end

end
