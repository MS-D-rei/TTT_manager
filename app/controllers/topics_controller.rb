class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
  end
  
  def show
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
  end

  def destroy
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :description, :priority, :deadline, :status)
  end
end
