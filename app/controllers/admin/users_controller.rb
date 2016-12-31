class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :destroy
  before_action :verify_admin, only: :destroy

  def index
    @users = User.order_date_desc.paginate page: params[:page],
      per_page: Settings.per_page.user
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "user_not_deleted"
    end
    redirect_to admin_users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end
end
