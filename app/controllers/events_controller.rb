class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]


  def index
    @teams = Team.order('label ASC')
    respond_to do |format|
      format.html
      format.json {
        @events = Event.get_public_events(params[:start], params[:end])
      }
    end
  end

  def new
    @event = Event.new(begin_at: params[:start_at], end_at: params[:end_at])

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
  end

  # GET /events/1/edit
  def edit
    if @event.organizer_type == 'Team'
      @members = @event.organizer.users.order('firstname ASC')
    end
    respond_to do |format|
      format.js
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to :back, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.organizer_type == 'Team'
      @members = @event.organizer.users.order('firstname ASC')
    end
    @event.update(event_params)
    respond_to do |format|
      format.js
      format.html{
        if @event.organizer_type == 'Team'
          redirect_to team_path(@event.organizer_id), notice: 'Event was successfully created.'
        else
          redirect_to :back
        end
      }
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if @event.organizer_type == 'Team'
      team_id = @event.organizer_id
    end

    @event.destroy
    respond_to do |format|
      format.html {
        if !team_id.blank?
          redirect_to team_path(@event.organizer_id), notice: 'Evénement supprimé'
        else
          redirect_to :back, notice: 'Evénement supprimé'
        end
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.required(:event).permit(:label, :description, :begin_at, :end_at, :organizer_id, :organizer_type, :is_public,
                                      assignments_attributes: [:id, :user_id, :description, :_destroy])
    end
end
