class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_event_available?
  before_action :is_user_admin?, only: [:new, :create]

  def new
    @event = Event.find(params[:event_id])
    @attendee = User.find(helpers.current_user.id)
    @attendance = Attendance.new(event: @event, user: @attendee)
  end

  def create_params
    params.permit(:first_name, :last_name, :email, :event_id)
  end

  def create
    # 1. On retrouve le User et l'Event nécessaires pour créer l'Attendance.
    user = User.find_by(email: create_params[:email])
    event = Event.find(create_params[:event_id])

    #2. On crée l'Attendance.
    @attendance = Attendance.new(user: user,
                                 event: event,
                                 payment_status: "pending")

    #3. On save l'Attendance créé.
    if @attendance.save
      #On passe au paiement : Charges#new
      redirect_to new_charge_path(event_id: event.id)
    else
      #On render + flash
      flash[:danger] = "Echec :" + @attendance.errors.full_messages.join(" ")
      render :new
    end
  end

  private

  def is_user_admin?
    if Event.find(params[:event_id]).host == helpers.current_user
      redirect_to root_path
      flash[:warning] = "Vous ne pouvez pas vous inscrire à votre propre évènement."
    end
  end

  def is_event_available?
    if Event.find(params[:event_id]).status != "validated"
      redirect_to event_path(params[:event_id])
      flash[:warning] = "Il n'est pas possible de rejoindre cet évènement."
    end
  end
end
