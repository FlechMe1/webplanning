class Ability
  include CanCan::Ability

  def initialize(user)


    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    else
      team_member_ids = user.memberships.pluck(:team_id)
      team_leader_ids = user.memberships.where(is_leader: true).pluck(:team_id)
      events_ids = Event.where(organizer_type: 'Team', organizer_id: team_leader_ids).pluck(:id) + Event.where(organizer_type: 'User', organizer_id: user.id).pluck(:id)
      can :read, Team, id: team_member_ids
      can [:read, :update], Team, id: team_leader_ids
      can [:read,], Event, id: events_ids
      can [:read, :create], User
    end
  end
end
