class ErrorsController < ApplicationController
  def error_500
  	render :status => 500
  end
end
