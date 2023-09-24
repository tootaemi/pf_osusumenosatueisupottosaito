class Admin::SessionsController < Devise::SessionsController
  skip_before_action :method_name, raise: false

  def new
  end

  def after_sign_in_path_for(resource)
    admin_root_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
