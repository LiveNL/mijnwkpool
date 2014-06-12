class PagesController < ApplicationController
  def home
    if current_user
      redirect_to app_root_path
    else
      render layout: 'home'
    end
  end
  
  def speluitleg
  end
end
