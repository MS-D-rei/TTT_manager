class AssignsController < ApplicationController
  before_action :authenticate_user!

  def create
    user_id = params[:assign][:user_id]
    team_id = params[:assign][:team_id]
    # return if a assign already has the team_id and user_id combination
    return unless Assign.find_by(user_id: user_id, team_id: team_id).nil?
    # return unless Assign.where(user_id: user_id, team_id: team_id).blank?

    @assign = Assign.new(assign_params)
    if @assign.save
      flash[:success] = 'New member joined this team'
    else
      flash[:danger] = 'Please select the user who you want to invite'
    end
    redirect_to team_path(@assign.team_id)
  end

  def destroy
    user_id = params[:user_id]
    team_id = params[:team_id]
    @assign = Assign.find_by(user_id: user_id, team_id: team_id)
    if @assign
      @assign.destroy
      flash[:info] = 'The member depart from this team'
    else
      flash[:danger] = 'The member is not assigned to this team'
    end
    redirect_to team_path(team_id)
  end

  private

  def assign_params
    params.require(:assign).permit(:user_id, :team_id)
  end
end
