class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
    @attendance = Attendance.where(event_id: @event.id)
  end

  def new
    @event = Event.new
    #@locations = []
    #Event.all do |event|
    #  @locations = event.location
    #end
  end

  def create_params
    params.permit(:title, :description, :location, :start_date, :duration, :price)
  end

  def create
    pp params

    host = helpers.current_user

    @event = Event.new(title: create_params[:title],
                       description: create_params[:description],
                       location: create_params[:location],
                       start_date: create_params[:start_date].to_datetime,
                       duration: create_params[:duration],
                       price: create_params[:price],
                       host: host)

    if @event.save
      redirect_to event_path(@event.id)
      flash[:success] = "Votre évènement a bien été créé."
    else
      flash[:danger] = "Echec lors de la création de l'évènement : " + @event.errors.full_messages.join(" ")
      render :new
    end
  end
end
