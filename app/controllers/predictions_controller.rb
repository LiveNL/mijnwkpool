class PredictionsController < ApplicationController
  def index
    @games = Game.all
    @predictions = Prediction.all
  end

  def new
    @games = Game.all
    @prediction = Prediction.new
    # @current_pool = Poolmembership.all(:conditions => {:user_id => current_user.id, :pool_id => pool.id})
  end

  def create
    @prediction = Prediction.new(prediction_params)
  	@prediction.game_id = params[:game_id]
    @prediction.poolmembership_id = params[:poolmembership_id]
  	 	if @prediction.save
        redirect_to pools_path
      else
        render 'new'
      end
	end

  def update
  end
  private
  def prediction_params
    params.require(:prediction).permit(:prediction1, :prediction2, :game_id, :poolmembership_id)
  end
end