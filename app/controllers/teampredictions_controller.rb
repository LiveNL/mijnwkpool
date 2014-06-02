class TeampredictionsController < ApplicationController
	def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @teampredictions = Teamprediction.all
	end

	def new
    @pool = Pool.find(params[:pool_id])
    @games = Game.order(:poule)
    # @predictions = Prediction.all
    @gamelist = @games.group_by { |t| t.poule }
 	end
 	
  private

  def find_teamprediction
    @teamprediction ||= Teamprediction.find(params[:teamprediction_id])
  end

  def teamprediction_params
    params.require(:teamprediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end	
end
