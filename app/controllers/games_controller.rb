class GamesController < ApplicationController
  def index
    @games = Game.find(1)
    @predictions = Prediction.all

    if @games.score1 == @predictions.score1 && @games.score2 == @predictions.score2
      puts '+10 punten'
    elsif @games.score2 == @predictions.score2
      puts '+8 punten'
    elsif @games.score1 == @predictions.score1
      puts '+5 punten'
    else
      puts '+0 punten'
    end
  end
end


