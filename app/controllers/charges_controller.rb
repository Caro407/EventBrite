class ChargesController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    # Amount in cents
    @event = Event.find(params[:event_id])
    @user = User.find(helpers.current_user.id)
    @amount = @event.price * 100
    @attendance = Attendance.where(user: @user, event: @event).first

    if @attendance != nil && @attendance.payment_status == "pending"
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      begin
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: "Rails Stripe customer",
          currency: "usd",
        })
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
        return
      end

      @attendance.payment_status = "paid"
      @attendance.save!
      redirect_to root_path #Voir si on peut créer une liste des events pour l'y rediriger
      flash[:success] = "Votre inscription a bien été prise en compte !"
    else
      redirect_to root_path
      flash[:danger] = "Votre requête n'a pas pu aboutir."
    end
  end
end
