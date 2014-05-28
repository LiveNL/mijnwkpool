class PredictionsController < ApplicationController
  respond_to :html, :json

  def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @predictions = Prediction.all
  end

  def new
    @pool = Pool.find(params[:pool_id])
    @games = Game.order(:poule)
    # @predictions = Prediction.all
    @gamelist = @games.group_by { |t| t.poule }
  end

  def pouleeindstanden
    @pool = Pool.find(params[:pool_id])
  end

  def knockoutfase
    @pool = Pool.find(params[:pool_id])
  end

  def bonusvragen
    @pool = Pool.find(params[:pool_id])
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
    params[:predictions].each do |k, v|
      prediction = Prediction.new(v)
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
    @prediction.update_attributes(prediction_params)
    respond_with @prediction
  end

  def pointsscript
    @games = Game.all
    @predictions = Prediction.all  
    @games.each do |game| 
      @predictions.each do |prediction| 
        if game.id == prediction.game_id 
          if game.score1 == nil && game.score2 == nil 
          else 
            if game.score1 < game.score2 && prediction.prediction1 < prediction.prediction2 
              if game.score1 == prediction.prediction1 && game.score2 == prediction.prediction2    
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 12
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 12
                  prediction.save 
                end 
              elsif game.score2 == prediction.prediction2 
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 7
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 7
                  prediction.save 
                end 
              else 
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 5
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 5
                  prediction.save 
                end 
              end 

            elsif game.score1 > game.score2 && prediction.prediction1 > prediction.prediction2 
              if game.score1 == prediction.prediction1 && game.score2 == prediction.prediction2 
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 12
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 12
                  prediction.save 
                end 
              elsif game.score2 == prediction.prediction2 
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 7
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 7
                  prediction.save 
                end 
              else 
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 5
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 5
                  prediction.save 
                end 
              end 

            elsif game.score1 == game.score2 && prediction.prediction1 == prediction.prediction2 
              if game.score1 == prediction.prediction1 && game.score2 == prediction.prediction2 
                if prediction.pointsgiven == 1   
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 12
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 12
                  prediction.save 
                end 
              
              else
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 5
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 5
                  prediction.save 
                end 
              end 
              
            else   
              if game.score1 == prediction.prediction1 
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 2
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 2
                  prediction.save 
                end 

              elsif game.score2 == prediction.prediction2 
                if prediction.pointsgiven == 1 
                else 
                  scoreupdate = Poolmembership.find(prediction.poolmembership_id) 
                  myes = scoreupdate.score + 2
                  score5 = scoreupdate 
                  score5.score = myes 
                  score5.save 
                  prediction.pointsgiven = 1 
                  prediction.pointsearned = 2
                  prediction.save 
                end 
              else 
              end 
            end 
          end 
        else  
        end 
      end 
    end
    redirect_to givepoints_path    
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
    params.require(:prediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end
end
