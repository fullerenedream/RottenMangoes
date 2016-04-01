class Admin::UsersController < ApplicationController

  before_filter :is_admin?

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # hack for now to get things moving
      if params[:admin] == "1"
        @user.admin = true
        @user.save!
      end

      redirect_to admin_user_path, notice: "User #{@user.firstname} #{@user.lastname} successfully created!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user_path, notice: "User #{@user.firstname} #{@user.lastname} successfully updated!"
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:admin, :email, :firstname, :lastname, :password, :password_confirmation)
  end

end
