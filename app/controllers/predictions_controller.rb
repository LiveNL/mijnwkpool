class PredictionsController < ApplicationController
  respond_to :html, :json

  def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @predictions = Prediction.all
  end 

  def new
    pool_id = params[:pool_id].to_i
    @pool = Pool.find_by_id(pool_id)
    @games = Game.all
  end

  def create
  	@predictions = Prediction.new(prediction_params)
  	 	if @prediction.save
        redirect_to app_root_path
      else
        render 'new'
      end
	end

  def create_multiple_predictions
    params[:predictions].each do |k,v|
      prediction = Prediction.new
      prediction.prediction1 = v['prediction1']
      prediction.prediction2 = v['prediction2']
      prediction.poolmembership_id = v['poolmembership_id']
      prediction.game_id = v['game_id']
      prediction.save
    end
    redirect_to app_root_path
  end
 
  def edit
  end

  def show
    @pool = Pool.all
    @games = Game.all
    @predictions = Prediction.all
  end

  def update
    @prediction = Prediction.find(params[:id])
    @prediction.update_attributes(params.require(:prediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id))
    respond_with @prediction
  end

  def givepoints
    @games = Game.all
    @predictions = Prediction.all
  end


  private
  def find_poolmembership
    @poolmembership ||= Poolmembership.find(params[:poolmembership_id])
  end      

  def prediction_params
    params.require(:prediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id)
  end
end


   