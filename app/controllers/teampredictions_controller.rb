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
  
  def show
    @pool = Pool.find(params[:id])
    @teams = Team.order(:poule)
    @teamlist = @teams.group_by { |t| t.poule }
  end

  def edit
    @pool = Pool.find(params[:id])
    @teams = Team.order(:poule)
    @teamlist = @teams.group_by { |t| t.poule }
    @team = Team.all

    @teamlist.sort.each_with_index do |(poule, teams), index|
      if @present
        return
      else
        teams.each_with_index do |team, index2|
          current_poolmembership = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id)
          teamprediction = Teamprediction.find_by_poolmembership_id_and_team_id(current_poolmembership, team.id)

          if teamprediction.present?
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

  def create_multiple_teampredictions
    params[:teampredictions].each do |k, v|
      teamprediction = Teamprediction.new(v)
      teamprediction.save
    end
    poolid = params[:pool_id]
    redirect_to teamprediction_path(poolid)
  end

  def update_multiple_teampredictions
    params[:teampredictions].each do |k, v|
      @teamprediction = Teamprediction.find(v[:id])
      @teamprediction.update(v)
    end
    poolid = params[:pool_id]
    redirect_to teamprediction_path(poolid)
  end

  def update
    @teamprediction = Teamprediction.find(params[:id])
    @teamprediction.update_attributes(teamprediction_params)
    respond_with @teamprediction
  end

  private

  def find_teamprediction
    @teamprediction ||= Teamprediction.find(params[:teamprediction_id])
  end

  def teamprediction_params
    params.require(:teamprediction).permit(:pouleposition, :prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end 
end
