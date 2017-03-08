class SessionsController < ApplicationController

  # Log in form
  def new
    @user = User.new
  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    if is_from_google(user)
      log_in(user)
      redirect_to parents_path
    else
      user = User.find_by(email: params[:session][:email].downcase)

      if user and user.authenticate(params[:session][:password])
        if user.activated?
          log_in(user)
          params[:session][:remember_me] ? remember(user) : forget(user)
          redirect_to parents_path
        else
          message  = 'Account not activated. '
          message += 'Check your email for the activation link.'
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render :new
      end
    end
  end

  # Log out form
  def destroy
    log_out if logged_in?
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def is_from_google(user)
    puts user.inspect
    !user.nil? and user.respond_to?('provider') and (user.provider == 'google_oauth2' or user.provider == 'facebook')
  end
end
