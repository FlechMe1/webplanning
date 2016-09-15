class PagesController < ApplicationController
  before_filter :authenticate_user!

  def home
    @teams = current_user.teams
    @event = current_user.events.build
  end

end
