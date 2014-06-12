class PredictionsController < ApplicationController
  before_filter :ensure_admin, :only => [:pointsscript, :pointsscript2, :givepoints, :givepoints2]

  respond_to :html, :json

  def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @predictions = Prediction.all
  end

  def new
    @pool = Pool.find(params[:pool_id])
    @games = Game.where(:poule => ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']).order(:poule, :date)
    @gamelist = @games.group_by { |t| t.poule }
  end

  def pouleeindstanden
    @pool = Pool.find(params[:id])
  end

  def knockoutfase
    @pool = Pool.find(params[:id])
  end

  def bonusvragen
    @pool = Pool.find(params[:id])
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
    poolid = params[:pool_id]
    p = Prediction.last
    if p.final == 4
      redirect_to knockoutprediction_path(poolid)
    elsif p.final == 3
      redirect_to knockoutprediction_path(poolid)
    elsif p.final == 2
      redirect_to knockoutprediction_path(poolid)
    elsif p.final == 1
      redirect_to knockoutprediction_path(poolid)
    else
      redirect_to prediction_path(poolid)
    end
  end

  def update_multiple_predictions
   params[:predictions].each do |k, v|
      @predictions = params[:predictions][k]
      @prediction = Prediction.find(v[:id])
      @prediction.update(v)
    end
    poolid = params[:pool_id]
    if @prediction.final == 4
      redirect_to knockoutprediction_path(poolid)
    elsif @prediction.final == 3
      redirect_to knockoutprediction_path(poolid)
    elsif @prediction.final == 2
      redirect_to knockoutprediction_path(poolid)
    elsif @prediction.final == 1
      redirect_to knockoutprediction_path(poolid)
    else
      redirect_to prediction_path(poolid)
    end
  end

  def edit
    if Time.now > deadline
      @pool = Pool.find(params[:id])
      render 'deadline'
    else
      @pool = Pool.find(params[:id])
      @games = Game.where(:poule => ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']).order(:poule, :date)
      @gamelist = @games.group_by { |t| t.poule }
      @gamelist.sort.each_with_index do |(poule, games), index|
        if @present
          return
        else
          games.each_with_index do |game, index2|
            current_poolmembership = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id)
            prediction = Prediction.find_by_poolmembership_id_and_game_id(current_poolmembership, game.id)

            if prediction.present?
              @present = true
            end
          end
        end
      end
      if @present
        render 'edit'
      else
        render 'new'
      end
    end
  end

  def show
    @pool = Pool.find(params[:id])
    @games = Game.where(:poule => ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']).order(:poule, :date)
    @gamelist = @games.group_by { |t| t.poule }
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
                  game.completed = true
                  game.save
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
                  game.completed = true
                  game.save
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
                  game.completed = true
                  game.save
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
                  game.completed = true
                  game.save
                end
              elsif game.score1 == prediction.prediction1
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
                  game.completed = true
                  game.save
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
                  game.completed = true
                  game.save
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
                  game.completed = true
                  game.save
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
                  game.completed = true
                  game.save
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
                  game.completed = true
                  game.save
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
                  game.completed = true
                  game.save
                end
              else
                game.completed = true
                game.save
              end
            end
          end
        else
        end
      end
    end
    redirect_to givepoints_path
  end

  def pointsscript2
    @teams = Team.all
    @teampredictions = Teamprediction.all
    @teams.each do |team|
      @teampredictions.each do |teamprediction|
        if team.id == teamprediction.team_id
          if team.original_position == nil
          else
            if team.original_position == teamprediction.pouleposition
                if teamprediction.pointsgiven == 1
                else
                  scoreupdate = Poolmembership.find(teamprediction.poolmembership_id)
                  myes = scoreupdate.score + 3
                  score5 = scoreupdate
                  score5.score = myes
                  score5.save
                  teamprediction.pointsgiven = 1
                  teamprediction.pointsearned = 3
                  teamprediction.save
                  team.completed = true
                  team.save!
                end
              else
            end
          end
        else
        end
      end
    end
    redirect_to givepoints2_path
  end

  def givepoints
    @games = Game.all
    @predictions = Prediction.all
  end

  def givepoints2
    @teams = Team.all
    @teampredictions = Teamprediction.all
  end

  private

  def find_poolmembership
    @poolmembership ||= Poolmembership.find(params[:poolmembership_id])
  end

  def prediction_params
    params.require(:prediction).permit(:winner, :prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end
end
