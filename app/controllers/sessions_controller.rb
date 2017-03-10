class SessionsController < ApplicationController

  # Log in form
  def new
    if logged_in?
      redirect_to parents_path
    else
      @user = User.new
    end
  end

  def create
    if request.env['omniauth.auth'].nil?
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
    else
      user = User.from_omniauth(request.env['omniauth.auth'])
      if is_from_auth(user)
        log_in(user)
        redirect_to parents_path
      else
        redirect_to root_url
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

  def is_from_auth(user)
    puts user.inspect
    !user.nil? and user.respond_to?('provider') and (user.provider == 'google_oauth2' or user.provider == 'facebook')
  end
end
