class Users::EventsController < ApplicationController
  require 'icalendar'

  before_filter :set_user

  def index
    respond_to do |format|
      format.html
      format.json{
        @teams = @user.teams
      }
      format.ics{
        @events = Event.get_personnal_events(@user.id)
        cal = Icalendar::Calendar.new
        cal.x_wr_calname = 'EGLISE DE BLOIS - Mon Planning'
        @events.each do |ev|
          cal.event do |e|
            e.dtstart     = ev.begin_at.utc
            e.dtend       = ev.end_at.utc
            e.summary     = ev.label
            e.description = ev.label
          end
        end
        cal.publish
        render plain: cal.to_ical
      }
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

end
