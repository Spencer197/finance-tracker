#This controller inherits all the behaviour of Devise::RegistrationsController 
#and tells Rails to first look for registations details in User::RegistrationsController before Devise::RegistrationsController.
class User::RegistrationsController < Devise::RegistrationsController 
  before_action :configure_permitted_parameters
  
  protected#Why should the method below be protected? Devise documentation doesn't say why either.
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])#Permits first & last name for sign_up.
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])#Permits first & last name for account_update(user profile edit).
  end
  
end