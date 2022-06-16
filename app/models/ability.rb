class Ability
  include CanCan::Ability

  def initialize(user)


    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    else
      user.structures.each do |s|
        if user.has_role? :admin, s
          can :manage, s.users
          can :manage, s.families
          can :manage, s.members
        end
      end
    end
  end
end
