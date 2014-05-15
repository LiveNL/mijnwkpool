class PredictionsController < ApplicationController
  def index
    @games = Game.all
    @predictions = Prediction.all
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
    params.require(:prediction).permit(:score1, :game)
  end
end
