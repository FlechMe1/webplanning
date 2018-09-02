class PagesController < ApplicationController

  def home
    @teams = current_user.teams
    @event = current_user.events.build
  end

end
