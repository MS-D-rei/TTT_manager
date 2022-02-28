class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :logged_in_user, only: %i[show]
  before_action :set_q, only: %i[show search]

  def index
    @users = User.all
  end

  def show
    return @user = User.includes(teams: { topics: :tasks }).find(current_user.id) if params[:id].nil?

    @user = User.includes(teams: { topics: :tasks }).find(params[:id])
  end

  def search
    @results = @q.result.includes(topic: :team)
  end

  private

  def logged_in_user
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def set_q
    @q = current_user.tasks.ransack(params[:q])
  end
end
