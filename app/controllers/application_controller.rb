class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:alert] = t "please_login"
      redirect_to login_path
    end
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "access_denied"
      redirect_to root_url
    end
  end

  def load_user
    @user = User.find_by_id params[:id]
    unless @user
      flash[:danger] = t "user_load_fail"
      redirect_to admin_users_path
    end
  end
end
