class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper, ApplicationHelper

  private
    def require_log_in
      unless logged_in?
        flash[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user and current_user.admin?
    end
end
