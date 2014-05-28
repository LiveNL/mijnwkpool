class GamesController < ApplicationController
  before_filter :ensure_admin
  before_action :set_game, only: [:show, :edit, :update, :destroy, :toggle]

  def index
    @game = Game.new
    @games = Game.all
    @teams = Team.all
  end

  # GET /games/1/edit
  def edit
  end

  def create
    @game = Game.new(game_params)
    @game.gametype = (params[:gametype])
    @game.team1_id = (params[:team1_id])
    @game.team2_id = (params[:team2_id])
    if @game.save
      flash[:success] = 'Game toegevoegd.'
      redirect_to games_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to games_path, notice: 'Score was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end

  def show
  end

  def toggle
    @game.toggle!(:completed)
    redirect_to pointsscript_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:score1, :score2, :team1_id, :team2_id, :gametype, :date, :time, :poule)
  end
end
