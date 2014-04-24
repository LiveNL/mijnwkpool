class PagesController < ApplicationController
layout :home_layout

	def home
	end

  def home_layout
    # Check if logged in, because current_user could be nil.
    if current_user
      "application"
    else
      "home"
    end
  end

end