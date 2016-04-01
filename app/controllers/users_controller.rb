class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:admin] == "1"
      @user.admin = true
      @user.save!
    end
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
