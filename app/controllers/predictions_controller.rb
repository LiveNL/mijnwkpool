class PredictionsController < ApplicationController
  def index
    @games = Game.find(3)
    @predictions = Prediction.all
  end
end
