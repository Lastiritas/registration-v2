class RegistrationCartsController < ApplicationController
  include CurrentRegistrationCart
  before_action :require_log_in
  before_action :validate_parent_is_set_under_registration_cart

  # GET /registration_carts/1
  # GET /registration_carts/1.json
  def show
    @parent = @registration_cart.parent
  end

  # DELETE /registration_carts/1
  # DELETE /registration_carts/1.json
  def destroy
    @registration_cart.destroy
    respond_to do |format|
      format.html { redirect_to registration_carts_url, notice: 'Registration cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
