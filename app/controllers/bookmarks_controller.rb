class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarked_tasks = current_user.bookmarked_tasks
  end

  def create
    @task = Task.find(params[:task_id])
    current_user.bookmark(@task)
    redirect_to request.referer
  end

  def destroy
    @task = current_user.bookmarks.find(params[:id]).task
    current_user.unbookmark(@task)
    redirect_to request.referer
  end
end
