require 'rails_admin/main_controller'

module RailsAdmin
  class MainController < RailsAdmin::ApplicationController
    rescue_from CanCan::AccessDenied do |exception|
      flash[:danger] = 'Access denied, only admin user can access admin pages'
      redirect_to main_app.root_path
    end
  end
end
