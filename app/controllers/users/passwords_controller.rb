# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :not_guest_user, only: :create
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  def not_guest_user
    return unless params[:user][:email].downcase == 'guest@mail.com'

    flash[:danger] = 'ゲストユーザーのパスワードは再設定できません'
    redirect_to new_user_session_path
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
