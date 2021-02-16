class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :can_read_profile, only: [:show]

  def show
    @user = helpers.current_user
  end

  def edit
    @user = helpers.current_user
  end

  def update_params
    params.permit(:first_name, :last_name, :description)
  end

  def update
    @user = helpers.current_user

    @user.first_name = update_params[:first_name]
    @user.last_name = update_params[:last_name]
    @user.description = update_params[:description]

    if @user.save
      redirect_to user_path(@user.id)
      flash[:success] = "Les informations ont été correctement mises à jour."
    else
      flash[:danger] = "Echec : " + @user.errors.full_messages.join(" ")
      render :edit
    end
  end

  private

  def is_user_connected
    if helpers.authenticate_user! == false
      redirect_to new_user_session_path
      flash[:warning] = "Vous devez être connecté pour pouvoir accéder à cette page."
    end
  end

  def can_read_profile
    if helpers.current_user != User.find(params[:id])
      redirect_to root_path
      flash[:danger] = "Tu ne peux pas accéder au profil d'autres utilisateurs."
      return
    end
  end
end
