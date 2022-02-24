class TasksController < ApplicationController
  before_action :authenticate_user!

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.build(task_params)
    topic_id = params[:task][:topic_id]
    if @task.save
      flash[:success] = I18n.t('view.messages.create_task')
    else
      flash[:danger] = I18n.t('view.messages.failed_create_task')
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
      flash[:success] = I18n.t('view.messages.update_task')
      redirect_to topic_path(topic_id)
    else
      flash[:danger] = I18n.t('view.messages.failed_update_task')
      redirect_to edit_task_path(@task)
    end
  end

  def destroy
    @task = Task.find(params[:id])
    topic_id = @task.topic.id
    if current_user == @task.user || current_user == @task.team.leader
      @task.destroy
      flash[:success] = I18n.t('view.messages.delete_task')
    else
      flash[:danger] = I18n.t('view.messages.failed_delete_task')
    end
    redirect_to topic_path(topic_id)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :priority, :deadline, :status, :team_id, :topic_id)
  end
end
