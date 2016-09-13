class TeamsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.order('label ASC').includes(:users).paginate(:page => params[:page], :per_page => 25)
    @team = Team.new
  end

  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to :teams, notice: 'Equipe créée.'
    else
      render :new
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if @team.update(team_params)
      redirect_to :teams, notice: 'Equipe mise à jour'
    else
      render :edit
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Equipe supprimée'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.required(:team).permit(:label, :description)
    end
end
