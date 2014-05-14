class GamesController < ApplicationController
  def index
    @games = Game.all
    @teams = Team.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @game.gameteams.create(team1_id: (params[:team1_id]), team2_id: (params[:team2_id]))
      flash[:success] = 'Game toegevoegd.'
      redirect_to games_path
    else
      render 'new'
    end
  end

  # def destroy
  #   @game = Game.find(params[:id])
  #   @game.destroy
  # end

private

  def game_params
    params.require(:game).permit(:score1, :score2, :team1_id, :team2_id)
  end
end
