class KnockoutpredictionsController < ApplicationController
  before_action :fourthround, :only => [:show, :edit]
  before_filter :ensure_admin, :only => [:pointsscript, :pointsscript2, :givepoints, :givepoints2]
  respond_to :html, :json
  def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @predictions = Prediction.all
  end

  def show
    @pool = Pool.find(params[:id])
    @gameseight = Game.where(gametype: 'Achtste finale').order(date: :asc)
    @gamesquarter = Game.where(gametype: 'Kwart finale').order(date: :asc)    
    @gameseightlist = @gameseight.group_by { |t| t.gametype }
    @gamesquarterlist = @gamesquarter.group_by { |t| t.gametype }    
  end

  def fourthround
    @pool = Pool.find(params[:id])
    poolmem = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id).id
    @array = [
      { #1
        team1: {
          pos: 1,
          poule: 'A',
          poolmembership_id: poolmem
        },
        team2: {
          pos: 2,
          poule: 'B',
          poolmembership_id: poolmem         
        }
      },
      { #2
        team1: {
          pos: 1,
          poule: 'C',
          poolmembership_id: poolmem        
        },
        team2: {
          pos: 2,
          poule: 'D',
          poolmembership_id: poolmem         
        }
      },
      { #3
        team1: {
          pos: 1,
          poule: 'B',
          poolmembership_id: poolmem
        },
        team2: {
          pos: 2,
          poule: 'A',
          poolmembership_id: poolmem         
        }
      },
      { #4
        team1: {
          pos: 1,
          poule: 'D',
          poolmembership_id: poolmem
        },
        team2: {
          pos: 2,
          poule: 'C',
          poolmembership_id: poolmem         
        }
      },
      { #5
        team1: {
          pos: 1,
          poule: 'E',
          poolmembership_id: poolmem
        },
        team2: {
          pos: 2,
          poule: 'F',
          poolmembership_id: poolmem         
        }
      },
      { #6
        team1: {
          pos: 1,
          poule: 'G',
          poolmembership_id: poolmem
        },
        team2: {
          pos: 2,
          poule: 'H',
          poolmembership_id: poolmem         
        }
      },
      { #7
        team1: {
          pos: 1,
          poule: 'F',
          poolmembership_id: poolmem
        },
        team2: {
          pos: 2,
          poule: 'E',
          poolmembership_id: poolmem         
        }
      },
      { #8
        team1: {
          pos: 1,
          poule: 'H',
          poolmembership_id: poolmem
        },
        team2: {
          pos: 2,
          poule: 'G',
          poolmembership_id: poolmem         
        }
      }                                          
    ] 
  end

  def edit
    @pool = Pool.find(params[:id])
    @gameseight = Game.where(gametype: 'Achtste finale').order(date: :asc)
    @gamesquarter = Game.where(gametype: 'Kwart finale').order(date: :asc)    
    @gameseightlist = @gameseight.group_by { |t| t.gametype }
    @gamesquarterlist = @gamesquarter.group_by { |t| t.gametype }    

      if @present
        return
      else
        @gameseight.each_with_index do |game, index2|
          current_poolmembership = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id)
          prediction = Prediction.find_by_poolmembership_id_and_game_id(current_poolmembership, game.id)

          if prediction.present?
            @present = true
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

  def knockoutprediction_params
    params.require(:knockoutprediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end
end







 