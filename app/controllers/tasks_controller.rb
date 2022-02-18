class TasksController < ApplicationController
  before_action :authenticate_user!

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.build(task_params)
    topic_id = params[:task][:topic_id]
    if @task.save
      flash[:success] = 'Created new task'
    else
      flash[:danger] = 'Please input task title and description'
    end
    redirect_to topic_path(topic_id)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    topic_id = params[:task][:topic_id]
    if @task.update(task_params)
      flash[:success] = 'Updated the task'
      redirect_to topic_path(topic_id)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    topic_id = @task.topic.id
    @task.destroy
    flash[:success] = 'Deleted the topic'
    redirect_to topic_path(topic_id)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :priority, :deadline, :status, :team_id, :topic_id)
  end
end
