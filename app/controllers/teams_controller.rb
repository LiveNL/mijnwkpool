class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @teams = Team.all
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = 'Team toegevoegd.'
      redirect_to new_team_path
    else
      @teams = Team.all      
      render 'new'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:success] = 'Team verwijderd.'
    redirect_to new_team_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :poule, :avatar)
  end
end
