class ApplicationController < ActionController::Base
  before_filter :ensure_user, :except => [:home]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def welcome
  end

  private

  def second_user
    @second_user ||= User.find(2) # (session[:user_id]) if session[:user_id]
  end

  def ensure_user
    if current_user
    else
    "ensure_user"
    flash[:error] = 'Registreer of log in om deze pagina te bekijken.'
    redirect_to root_path
    end
  end
end