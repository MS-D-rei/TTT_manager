class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = 'New team has been created'
    else
      flash[:danger] = 'Please input team name'
    end
    redirect_to teams_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def team_params
    params.require(:team).permit(:name, :leader_id)
  end
end
