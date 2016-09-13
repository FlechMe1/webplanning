module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :birthdate])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :birthdate])
    devise_parameter_sanitizer.permit(:invite, keys: [:firstname, :lastname, :email])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:firstname, :lastname, :password, :password_confirmation])
  end

end

DeviseController.send :include, DevisePermittedParameters
