class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
    @attendance = Attendance.where(event_id: @event.id)
  end
end
