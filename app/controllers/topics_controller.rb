class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update destroy]
  

  def index
  end
  
  def show
    @topic = Topic.includes(:user).find(params[:id])
  end

  def new
    @topic = current_user.topics.new
  end

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:success] = 'Created a new topic'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      flash[:success] = 'Updated the topic content'
      redirect_to root_url
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
    params.require(:topic).permit(:title, :description, :priority, :deadline, :status)
  end
end
