class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.includes(:leader, :members).all
  end

  def show
    @team = Team.includes(assigns: :user, topics: :tasks).find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      user_id = current_user.id
      team_id = @team.id
      # create Assign for this new team
      Assign.create(user_id: user_id, team_id: team_id)
      flash[:success] = I18n.t('view.messages.create_team')
    else
      flash[:danger] = I18n.t('view.messages.failed_save_team')
    end
    redirect_to teams_path
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      flash[:success] = I18n.t('view.messages.update_team')
    else
      flash[:danger] = I18n.t('view.messages.failed_update_team')
    end
    redirect_to teams_path
  end

  def destroy
    @team = Team.find(params[:id])
    if @team.topics.blank?
      @team.destroy
      flash[:success] = I18n.t('view.messages.delete_team')
      redirect_to teams_path
    else
      flash[:danger] = I18n.t('view.messages.failed_delete_team')
      redirect_to request.referer
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :leader_id)
  end
end
