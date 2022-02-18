class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update destroy]
  

  def index
  end
  
  def show
    @topic = Topic.includes(tasks: :user).find(params[:id])
  end

  def create
    @topic = current_user.topics.build(topic_params)
    team_id = params[:topic][:team_id]
    flash[:success] = 'Created a new topic' if @topic.save
    redirect_to team_path(team_id)
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    team_id = params[:topic][:team_id]
    if @topic.update(topic_params)
      flash[:success] = 'Updated the topic content'
      redirect_to team_path(team_id)
    else
      flash.now[:danger] = 'Please edit again to fulfill the requirements'
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    flash[:success] = 'The topic has been deleted'
    redirect_to root_url
  end

  private

  def correct_user
    @topic = Topic.find(params[:id])

    redirect_to root_url unless current_user.topics.include?(@topic)
  end

  def topic_params
    params.require(:topic).permit(:title, :description, :priority, :deadline, :status, :team_id)
  end
end
