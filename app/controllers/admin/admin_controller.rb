class Admin::AdminController < ApplicationController
  layout "admin"
  before_action :is_admin?

  def index
    @admin = helpers.current_user
    @events_to_validate = Event.where(status: "to validate")
  end

  def is_admin?
    if helpers.current_user.is_admin != true
      redirect_to root_path
      flash[:warning] = "Vous ne pouvez pas accéder à cette page."
    end
  end
end
