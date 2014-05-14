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
      @game.gameteams.create(team1_id: 1, team2_id: 2)
      flash[:success] = 'Game toegevoegd.'
      redirect_to games_path
    else
      render 'new'
    end
  end


private

  def game_params
    params.require(:game).permit(:score1, :score2)
  end
end
