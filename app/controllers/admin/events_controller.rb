module Admin
  class EventsController < AdminController
    def index
      @events = Event.order(created_at: :desc)
    end

    def show
      @event = Event.find(params[:id])
    end
  end
end
