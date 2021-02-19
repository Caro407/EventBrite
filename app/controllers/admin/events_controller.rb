module Admin
  class EventsController < AdminController
    def index
      @events = Event.order(created_at: :desc)
    end

    def show
      @event = Event.find(params[:id])
    end

    def edit
      @event = Event.find(params[:id])
    end

    def update
      @event = Event.find(params[:id])

      @event.status = "validated"

      if @event.save!
        redirect_to admin_event_path(@event.id)
        flash[:success] = "L'évènement a été correctement validé."
      else
        redirect_to admin_event_path(@event.id)
        flash[:warning] = "Echec: " + @event.errors.full_messages.join(" ")
      end
    end
  end
end
