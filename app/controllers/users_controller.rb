class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :logged_in_user, only: %i[show]

  def index
    @users = User.all
  end

  def show
    return @user = current_user if params[:id].nil?

    @user = User.find(params[:id])
  end

  private

  def logged_in_user
    return if user_signed_in?

    # flash[:danger] = 'Please log in'
    redirect_to new_user_session_path
  end
end
