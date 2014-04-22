class SessionsController < ApplicationController
  def new
  end
 
  def create
    user = User.find_by(email: params[:session][:email])
    if user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to '/pools'
    else
      render "new"
    end
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to '/pools'
  end
end