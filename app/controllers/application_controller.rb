class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_sign_in_params, if: :devise_controller?
  helper_method :log_in, :current_customer, :log_out

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

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to posts_path
  end
  
end