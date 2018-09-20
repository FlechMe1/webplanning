class SchedulesController < ApplicationController

  def index
    @user = User.find params[:user_id]
    @teams = @user.teams
    respond_to do |format|
      format.ics{
        @events = Event.get_personnal_events(@user.id, DateTime.now)
        @cal = Icalendar::Calendar.new
        @cal.x_wr_calname = 'EGLISE DE BLOIS - Mon Planning'
        @cal.timezone do |t|
          t.tzid = "Europe/Paris"
          t.daylight do |d|
            d.tzoffsetfrom = "-0100"
            d.tzoffsetto   = "+0200"
            d.tzname       = "CDT"
            d.dtstart      = "19710101T030000"
            d.rrule        = "FREQ=YEARLY;WKST=MO;INTERVAL=1;BYMONTH=10;BYDAY=-1SU"
          end
        end
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