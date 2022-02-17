class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:leader).all
  end

  def show
    @team = Team.includes(:members).find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      user_id = current_user.id
      team_id = @team.id
      Assign.create(user_id: user_id, team_id: team_id)
      flash[:success] = 'New team has been created'
    else
      flash[:danger] = 'Please input team name'
    end
    redirect_to teams_path
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      flash[:success] = 'Team name has been updated'
    else
      flash[:danger] = 'Please input team name'
    end
    redirect_to teams_path
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:success] = 'The team has been disbanded'
    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :leader_id)
  end
end
