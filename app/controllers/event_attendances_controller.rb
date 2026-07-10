class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:attended_event_id])
    current_user.event_attendances.create(attended_event: @event)
    redirect_to event_path(@event), notice: "You are now attending this event!"
  end

  def destroy
    @attendance = current_user.event_attendances.find_by(attended_event_id: params[:id])
    @attendance.destroy
    redirect_to event_path(params[:id]), notice: "You are no longer attending this event."
  end
end
