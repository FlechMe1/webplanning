class Teams::MembershipsController < ApplicationController

  before_filter :set_team

  def index
    @members = @team.users.order('firstname ASC').paginate(:page => params[:page], :per_page => 25)
    @membership = @team.memberships.build
    @users = User.where('id NOT IN (?)', [0] + @members.map{|m| m.id}).order('lastname ASC')
  end

  def create
    @membership = @team.memberships.build(membership_params)

    if @membership.save
      redirect_to [@team, :memberships], notice: "Membre ajouté à l\'équipe"
    else
      render :edit
    end
  end

  def destroy
    membership = @team.memberships.where(user_id: params[:id]).first

    membership.destroy
    redirect_to [@team, :memberships], notice: "Membre supprimé à l\'équipe"
  end

  def promute
    membership = @team.memberships.where(user_id: params[:id]).first
    membership.is_leader = true

    if membership.save
      redirect_to [@team, :memberships], notice: "Membre promu"
    else
      render :edit
    end
  end

  def destitute
    membership = @team.memberships.where(user_id: params[:id]).first
    membership.is_leader = false

    if membership.save
      redirect_to [@team, :memberships], notice: "Membre destitué"
    else
      render :edit
    end
  end





  private
    def set_team
      @team = Team.find params[:team_id]
    end

    def membership_params
      params.required(:membership).permit(:user_id, :team_id, :is_leader)
    end

end
