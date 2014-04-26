class UsersController < ApplicationController
  skip_before_filter :ensure_user, :only => [:create, :new]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Succesvol geregistreerd en ingelogd.'
      redirect_to welcome_path
    else
      render 'new'
    end
  end

  def dashboard
    @user = User.find(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
  end
end
