module Admin
  class Admin::UsersController < AdminController
    def index
      @users = User.order(created_at: :desc)
    end

    def show
      @user = User.find(params[:id])
    end
  end
end
