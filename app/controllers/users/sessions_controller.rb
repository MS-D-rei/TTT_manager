# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   self.resource = resource_class.new(sign_in_params)
  #   clean_up_passwords(resource)
  #   yield resource if block_given?
  #   respond_with(resource, serialize_options(resource))
  # end

  # POST /resource/sign_in
  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message!(:notice, :signed_in)
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   respond_with resource, location: after_sign_in_path_for(resource)
  # end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user&.valid_password?(params[:user][:password])
      sign_in @user
    else
      flash[:danger] = 'Invalid email/password combination.'
    end
    redirect_to root_url
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:success] = 'ゲストアドミンユーザーとしてログインしました'
    redirect_to root_path
  end

  def guest_sign_in_as_normal
    user = User.guest_as_normal
    sign_in user
    flash[:success] = 'ゲストノーマルユーザーとしてログインしました'
    redirect_to root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
