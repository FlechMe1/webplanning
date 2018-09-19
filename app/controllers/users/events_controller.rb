class Users::EventsController < ApplicationController
  require 'icalendar'

  before_filter :set_user

  def index

  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

end
