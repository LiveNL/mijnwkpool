class KnockoutpredictionsController < ApplicationController
  before_action :eightteams, :only => [:show, :edit]
  before_action :quarterteams, :only => [:show] 
  before_action :semiteams, :only => [:show]  
  before_action :finalteams, :only => [:show]  

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
    @gameseightlist = @gameseight.group_by { |t| t.gametype }
    @gamesquarter = Game.where(gametype: 'Kwart finale').order(date: :asc)        
    @gamesquarterlist = @gamesquarter.group_by { |t| t.gametype }    
    @gamessemi = Game.where(gametype: 'Halve finale').order(date: :asc)        
    @gamessemilist = @gamessemi.group_by { |t| t.gametype }
    @gamesfinal = Game.where(gametype: 'Finale').order(date: :asc)        
    @gamesfinallist = @gamesfinal.group_by { |t| t.gametype }             
  end


  def eightteams
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

  def quarterteams
    # game_id_array = [101, 102, 103, 104, 105, 106, 107, 108] 
    # predictions = []
    # game_id_array.each do |id|
    #   predictions << Prediction.find_by_game_id([id])
    # end             
    # predictions.each_with_index do |p, idx|
    #   "team_#{idx}" = "#{Team.find_by_id(p.winner)}"
    # end 

    @pool = Pool.find(params[:id])
    poolmem = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id).id
    p1 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 101)
    winner1 = p1.winner
    p2 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 102)
    winner2 = p2.winner
    p3 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 103)
    winner3 = p3.winner
    p4 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 104)
    winner4 = p4.winner
    p5 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 105)
    winner5 = p5.winner
    p6 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 106)
    winner6 = p6.winner
    p7 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 107)    
    winner7 = p7.winner                       
    p8 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 108)
    winner8 = p8.winner

    @predictionarray = [
      { #1
        team1: {
          game_id: 101,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner1                                             
        },
        team2: {
          game_id: 102,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner2                                              
        }
      },
      { #2
        team1: {
          game_id: 103,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner3                                              
        },
        team2: {
          game_id: 104,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner4                                              
        }
      },
      { #3
        team1: {
          game_id: 105,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner5                                             
        },
        team2: {
          game_id: 106,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner6                                              
        }
      },
      { #4
        team1: {
          game_id: 107,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner7                                              
        },
        team2: {
          game_id: 108,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner8                                              
        }
      }               
    ] 
  end

  
   def semiteams
   @pool = Pool.find(params[:id])
    poolmem = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id).id
    p1 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 109)
    winner1 = p1.winner
    p2 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 110)
    winner2 = p2.winner
    p3 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 111)
    winner3 = p3.winner
    p4 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 112)
    winner4 = p4.winner
    @semipredictionarray = [
      { #1
        team1: {
          game_id: 109,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner1                                             
        },
        team2: {
          game_id: 110,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner2                                              
        }
      },
      { #2
        team1: {
          game_id: 111,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner3                                              
        },
        team2: {
          game_id: 112,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner4                                              
        }
      }               
    ] 
  end

  def finalteams
   @pool = Pool.find(params[:id])
    poolmem = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id).id
    p1 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 113)
    winner1 = p1.winner
    p2 = Prediction.find_by_poolmembership_id_and_game_id(poolmem, 114)
    winner2 = p2.winner
    @finalpredictionarray = [
      { #1
        team1: {
          game_id: 113,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner1                                             
        },
        team2: {
          game_id: 114,
          final: 4,
          poolmembership_id: poolmem,
          winner: winner2                                              
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
    @pool = Pool.find(params[:id])
    @gameseight = Game.where(gametype: 'Achtste finale').order(date: :asc)
    @gameseightlist = @gameseight.group_by { |t| t.gametype }
    @gameseightlist.sort.each_with_index do |(gametype, games), index|    
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







 