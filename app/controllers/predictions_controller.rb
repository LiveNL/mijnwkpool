class PredictionsController < ApplicationController
  def index
    @games = Game.all
    @predictions = Prediction.all
  end

  def new
    @prediction = Prediction.new
    @pool = Pool.all
    @game = Game.all
  end

  def create
  	@prediction = Prediction.new(prediction_params)
  	 	if @prediction.save
        redirect_to predictions_path
      else
        render 'new'
      end
	end

  def update
  end
  private
  def prediction_params
    params.require(:prediction).permit(:score1, :game, :prediction1, :prediction2, :game_id)
  end
end
