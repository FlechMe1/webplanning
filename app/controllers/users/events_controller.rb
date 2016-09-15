class Users::EventsController < ApplicationController

  before_filter :set_user

  def index
    respond_to do |format|
      format.html
      format.json {
        @events = @user.events.where('end_at BETWEEN ? AND ?', params[:start], params[:end])
      }
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
    
end
