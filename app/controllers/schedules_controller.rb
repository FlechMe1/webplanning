class SchedulesController < ApplicationController

  def index
    @user = User.find params[:user_id]
    @teams = @user.teams
    respond_to do |format|
      format.ics{
        @events = Event.get_personnal_events(@user.id, DateTime.now)
        @cal = Icalendar::Calendar.new
        @cal.x_wr_calname = 'EGLISE DE BLOIS - Mon Planning'
        @events.each do |ev|
          @cal.event do |e|
            e.dtstart     = ev.begin_at.utc
            e.dtend       = ev.end_at.utc
            e.summary     = ev.label
            e.description = ev.label
          end
        end
        @cal.publish

        render body: @cal.to_ical, mime_type: Mime::Type.lookup("text/calendar")
      }
    end
  end


end