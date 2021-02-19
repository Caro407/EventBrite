module Admin
  class EventsController < AdminController
    def show
      @event = Event.find(params[:id])
    end
  end
end
