class Association::TeamsController < AssociationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = @association.teams.order('label ASC').paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @members = @team.users.order('firstname ASC').paginate(:page => params[:page], :per_page => 25)
    @membership = @team.memberships.build
    @users = User.where('id NOT IN (?)', [0] + @members.map{|m| m.id}).order('lastname ASC')
  end

  def new
    @team = @association.teams.build
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = @association.teams.build(team_params)

    if @team.save
      redirect_to [:association, :teams], notice: 'Equipe créée.'
    else
      render :new
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if @team.update(team_params)
      redirect_to [:association, :teams], notice: 'Equipe mise à jour'
    else
      render :edit
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    redirect_to [:association, :teams], notice: 'Equipe supprimée'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.required(:team).permit(:label, :color, :description)
    end
end
