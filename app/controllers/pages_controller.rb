class PagesController < ApplicationController

  layout 'public'

  def home
    @teams = current_user.teams
    @event = current_user.events.build
  end

  def public_home
    if current_user
      redirect_to associations_url
    end
  end

end
