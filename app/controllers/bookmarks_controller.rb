class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarked_tasks = current_user.bookmarked_tasks
  end

  def create
    @task = Task.find(params[:task_id])
    @bookmark = @task.bookmarks.new(user_id: current_user.id)
    respond_to do |format|
      if @bookmark.save
        format.js { render :create }
      else
        format.html { redirect_to request.referer }
      end
    end
    # current_user.bookmark(@task)
  end

  def destroy
    @task = current_user.bookmarks.find(params[:id]).task
    @bookmark = @task.bookmarks.find_by(user_id: current_user.id)
    respond_to do |format|
      return format.html { redirect_to request.referer } if @bookmark.nil?

      @bookmark.destroy
      format.js { render :destroy }
    end
  end
end
