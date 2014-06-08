class QuarterpredictionsController < ApplicationController
 before_action :eightleader, :only => [:show, :edit]
  before_filter :ensure_admin, :only => [:pointsscript, :pointsscript2, :givepoints, :givepoints2]
  respond_to :html, :json
  def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @predictions = Prediction.all
  end

  def show
    @pool = Pool.find(params[:id])
    @games = Game.where(gametype: 'Kwart finale').order(date: :asc)
    @gamelist = @games.group_by { |t| t.gametype }    
  end

  def eightleader
    @array = [
      {
        team1: {
          final: 4,  
          poule: 'A',                  
          pos: 1
        },
        team2: {
          final: 4,           
          poule: 'B',                   
          pos: 2
        },
        team1: {
          final: 4,  
          poule: 'A',                  
          pos: 2
        },
        team2: {
          final: 4,           
          poule: 'B',                   
          pos: 1
        }        
      }
    ] 
  end

  def edit
  @pool = Pool.find(params[:id])
  @games = Game.where(gametype: 'Achtste finale').order(date: :asc)
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

  private

  def find_poolmembership
    @poolmembership ||= Poolmembership.find(params[:poolmembership_id])
  end

  def quarterprediction_params
    params.require(:quarterprediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end
end
