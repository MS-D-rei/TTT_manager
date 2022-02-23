class AssignsController < ApplicationController
  before_action :authenticate_user!

  def create
    user_id = params[:assign][:user_id]
    team_id = params[:assign][:team_id]
    # return if a assign already has the team_id and user_id combination
    unless Assign.find_by(user_id: user_id, team_id: team_id).nil?
      flash[:danger] = 'The user is already a member of this team'
      return redirect_to team_path(team_id) 
    end

    @assign = Assign.new(assign_params)
    if @assign.save
      flash[:success] = I18n.t('view.messages.create_assign')
    else
      flash[:danger] = I18n.t('view.messages.failed_create_assign')
    end
    redirect_to team_path(team_id)
  end

  def destroy
    user_id = params[:user_id]
    team_id = params[:team_id]
    @assign = Assign.find_by(user_id: user_id, team_id: team_id)
    if @assign
      @assign.destroy
      flash[:info] = I18n.t('view.messages.delete_assign')
    else
      flash[:danger] = I18n.t('view.messages.faild_delete_assign')
    end
    redirect_to team_path(team_id)
  end

  private

  def assign_params
    params.require(:assign).permit(:user_id, :team_id)
  end
end
