class TeamsController < ApplicationController
  before_filter :ensure_admin
  before_action :set_team, only: [:show, :edit, :update, :destroy, :toggle]
  
  def index
    @team = Team.new
    @teams = Team.all
  end

  def edit
  end

  def new
    @teams = Team.all
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = 'Team toegevoegd.'
      redirect_to teams_path
    else
      @teams = Team.all
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to teams_path, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:success] = 'Team verwijderd.'
    redirect_to new_team_path
  end

  def toggle
    @team.toggle!(:completed)
    redirect_to pointsscript2_path
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :poule, :avatar, :original_position)
  end
end
