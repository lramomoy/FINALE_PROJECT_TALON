class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :phone_number])
        
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :name, :phone_number, :current_password])
  # end

  def after_sign_in_path_for(resource)
    admin_administrators_url
  end
end
