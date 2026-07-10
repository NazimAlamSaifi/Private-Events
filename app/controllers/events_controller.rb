class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to root_path, notice: "Event successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update
    @event = current_user.created_events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = current_user.created_events.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Event deleted successfully."
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date)
  end
end
