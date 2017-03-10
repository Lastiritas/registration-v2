module CurrentRegistrationCart
  extend ActiveSupport::Concern

  private
  def set_or_create_registration_cart
    if !registration_cart_exists
      @registration_cart = RegistrationCart.create(user: current_user)
      session[:registration_cart_id] = @registration_cart.id
    end
  end

  def validate_parent_and_camper_are_set_under_registration_cart
    if registration_cart_exists
      if @registration_cart.parent.nil?
        redirect_to :controller => 'parents', :action => 'new'
      elsif !@registration_cart.campers.any?
        redirect_to :controller => 'registration_carts', :action => 'show', :id => @registration_cart.id
      end
    else
      redirect_to :controller => 'parents', :action => 'new'
    end
  end

  def validate_parent_is_set_under_registration_cart
    if !registration_cart_exists or @registration_cart.parent == nil
      redirect_to :controller => 'parents', :action => 'new'
    end
  end

  def registration_cart_exists
    @registration_cart = RegistrationCart.find(session[:registration_cart_id])
    return @registration_cart.user.id == current_user.id
  rescue ActiveRecord::RecordNotFound
    return false
  end
end