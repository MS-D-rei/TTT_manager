class TopicsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @topic = Topic.includes(tasks: :user).find(params[:id])
  end

  def create
    @topic = current_user.topics.build(topic_params)
    team_id = params[:topic][:team_id]
    if @topic.save
      flash[:success] = I18n.t('view.messages.create_topic')
    else
      flash[:danger] = I18n.t('view.messages.failed_create_topic')
    end
    redirect_to team_path(team_id)
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    team_id = params[:topic][:team_id]
    if @topic.update(topic_params)
      flash[:success] = I18n.t('view.messages.update_topic')
      redirect_to team_path(team_id)
    else
      flash[:danger] = I18n.t('view.messages.failed_update_topic')
      redirect_to edit_topic_path(@topic)
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    team_id = @topic.team.id
    if current_user == @topic.user || current_user == @topic.team.leader
      @topic.destroy
      flash[:success] = I18n.t('view.messages.delete_topic')
    else
      flash[:danger] = I18n.t('view.messages.failed_delete_topic')
    end
    redirect_to team_path(team_id)
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :description, :priority, :deadline, :status, :team_id)
  end
end
