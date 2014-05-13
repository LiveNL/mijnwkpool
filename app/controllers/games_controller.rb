class GamesController < ApplicationController
  def index
    @games = Game.all
    @teams = Team.all
  end
end
