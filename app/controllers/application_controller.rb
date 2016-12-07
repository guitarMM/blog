class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #before_action :configure_permitted_parameters, if: :devise_controller?

  #protected

  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  #end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    #strong parametersを設定し、usernameを許可
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:name, :email, :password, :remember_me) }
  end

end
