class TasksController < ApplicationController
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Created new task'
    else
      flash[:danger] = 'Please input task title and description'
    end
    redirect_to topic_path(@task.topic.id)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :priority, :deadline, :status, :team_id, :topic_id)
  end
end
