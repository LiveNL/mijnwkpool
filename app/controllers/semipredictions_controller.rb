class SemipredictionsController < ApplicationController
  before_action :semiteams, :only => [:show, :edit]  
  before_filter :ensure_admin, :only => [:pointsscript, :pointsscript2, :givepoints, :givepoints2]
  respond_to :html, :json
  def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @predictions = Prediction.all
  end

  def show
    @pool = Pool.find(params[:id])
  end

  def semiteams
   @pool = Pool.find(params[:id])
    poolmem = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id).id
    p1 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 109)
    if p1.present?
      winner1 = p1.winner
    end    
    p2 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 110)
    if p2.present?    
      winner2 = p2.winner
    end    
    p3 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 111)
    if p3.present?        
      winner3 = p3.winner
    end
    p4 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 112)
    if p4.present?
      winner4 = p4.winner
    end
    @semipredictionarray = [
      { #1
        team1: {
          game_id: 109,
          final: 3,
          poolmembership_id: poolmem,
          winner: winner1                                             
        },
        team2: {
          game_id: 110,
          final: 3,
          poolmembership_id: poolmem,
          winner: winner2                                              
        }
      },
      { #2
        team1: {
          game_id: 111,
          final: 3,
          poolmembership_id: poolmem,
          winner: winner3                                              
        },
        team2: {
          game_id: 112,
          final: 3,
          poolmembership_id: poolmem,
          winner: winner4                                              
        }
      }               
    ] 
  end

  def create
    @predictions = Prediction.new(prediction_params)
    if @prediction.save
      redirect_to app_root_path
    else
      render 'new'
    end
  end

  def edit
    if Time.now > deadline && if Time.now > knockout_deadline
      @pool = Pool.find(params[:id])
      render 'deadline'
    else       
      @pool = Pool.find(params[:id])
      @gamessemi = Game.where(gametype: 'Halve finale').order(date: :asc)
      @gamessemilist = @gamessemi.group_by { |t| t.gametype }
      @gamessemilist.sort.each_with_index do |(gametype, games), index|    
        if @present
          return
        else
          @gamessemi.each_with_index do |game, index2|
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

  private

  def find_poolmembership
    @poolmembership ||= Poolmembership.find(params[:poolmembership_id])
  end

  def semiprediction_params
    params.require(:knockoutprediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end
end







 