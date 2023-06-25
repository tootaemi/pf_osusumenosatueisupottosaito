 class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
   before_action :configure_sign_in_params, if: :devise_controller?
   
  # ログイン後のリダイレクト先
   def after_sign_in_path_for(resource)
     root_path(resource)
   end
   
  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    root_path(resource)
  end
  
  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :encrypted_password])
  end
  
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :encrypted_password])
  end
  
  # def configure_permitted_parameters
  #   if resource_class == Customer
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email, :encrypted_password])
  #   end
  # end
 end

