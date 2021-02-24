class EventsController < ApplicationController
  include EventsHelper

  before_action :authenticate_user!, only: [:new, :create]
  before_action :is_user_admin?, only: [:edit, :update]

  def index
    @events = Event.where(status: "validated")
  end

  def show
    @event = Event.find(params[:id])
    @attendance = Attendance.where(event_id: @event.id).paid
  end

  def new
    @event = Event.new
  end

  def create_params
    params.permit(:title, :description, :location, :start_date, :duration, :price)
  end

  def create
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

  def edit
    @event = Event.find(params[:id])
  end

  def update_params
    params.permit(:id, :title, :description, :start_date, :duration, :price)
  end

  def update
    @event = Event.find(update_params[:id])

    @event.title = update_params[:title]
    @event.description = update_params[:description]
    @event.start_date = update_params[:start_date]
    @event.duration = update_params[:duration]
    @event.price = update_params[:price]

    if @event.save
      redirect_to event_path(@event.id)
      flash[:success] = "Les informations ont été correctement mises à jour."
    else
      flash[:danger] = "Echec : " + @event.errors.full_messages.join(" ")
      render :edit
    end
  end

  private

  def is_user_admin?
    if Event.find(params[:id]).host != helpers.current_user
      redirect_to root_path
      flash[:warning] = "Vous ne pouvez pas modifier un évènement sans en être l'administrateur."
    end
  end
end
