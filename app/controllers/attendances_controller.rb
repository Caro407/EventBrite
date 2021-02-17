class AttendancesController < ApplicationController
  def new
    #prévoir la vérification de connexion et d'appartenance de l'event
    #prévoir le cas où l'event n'exsite pas encore
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
end
