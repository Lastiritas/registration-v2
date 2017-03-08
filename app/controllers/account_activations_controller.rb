class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    puts user.inspect
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in(user)
      flash[:success] = 'Account activated'
      Rails.logger.info "Account activated for #{user.email}"
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      Rails.logger.warn "Invalid activation link #{user.email}"
      redirect_to root_url
    end
  end
end
