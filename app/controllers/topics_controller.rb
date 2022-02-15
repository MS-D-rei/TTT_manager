class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
  end
  
  def show
    @topic = Topic.find(params[:id])
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
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :description, :priority, :deadline, :status)
  end
end
