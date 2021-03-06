class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      Rails.logger.info "Password reset email sent to user #{@user.email}"
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit
  end

  def update
    if both_passwords_blank?
      flash.now[:danger] = "Password and Password confirmation can't be blank"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      Rails.logger.info "Password has been changed for user #{@user.email}"
      flash[:success] = 'Password has been reset'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirm a valid user.
    def valid_user
      unless (@user && @user.activated? &&
          @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Returns true if password and confirmation are blank
    def both_passwords_blank?
      params[:user][:passwords].blank? &&
          params[:user][:password_confirmation].blank?
    end

    # Check the expiration of the token
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = 'Password reset has expired'
        Rails.logger.info "User tried to use an expired password reset link #{@user.email}"
        redirect_to new_password_reset_url
      end
    end
end
