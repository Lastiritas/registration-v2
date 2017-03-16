class SubmissionsController < ApplicationController
  include CurrentRegistrationCart
  before_action :require_log_in
  before_action :validate_parent_and_camper_are_set_under_registration_cart

  # GET /submissions/new
  def new
    @submission = Submission.new
    @parent = @registration_cart.parent
  end

  # POST /submissions
  def create
    charge = charge_payment
    @parent = @registration_cart.parent

    if is_charge_valid(charge)
      @submission = Submission.create(:charge_id => charge.id, :amount_paid => charge.amount)
      @submission.add_campers_and_parent_from_registration_cart(@registration_cart, current_user)

      respond_to do |format|
        if @submission.save
          RegistrationCart.destroy(session[:registration_cart_id])
          session[:registration_cart_id] = nil
          flash.now[:success] = 'Your registration was successfully added.'
          format.html { redirect_to parents_path }
        else
          refund_payment(charge)
          flash.now[:danger] = 'An error happened while trying to process your payment. We have not charged your card yet. Please, try again'
          format.html { render :new }
        end
      end
    else
      redirect_to new_submission_path
    end
  rescue => e
    Rails.logger.error "An error occurred while trying to create submission #{e}"
    refund_payment(charge)
    flash.now[:danger] = 'An error happened while trying to process your payment. We have not charged your card yet. Please, try again'
    redirect_to new_submission_path
  end

  private
    def charge_payment
      # Amount in cents
      @amount = (@registration_cart.total_price * 100).floor

      customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
          :customer             => customer.id,
          :amount               => @amount,
          :description          => "Charge for #{params[:stripeEmail]}",
          :currency             => 'cad',
          :statement_descriptor => 'Camp Wannakumbac'
      )

      return charge

    rescue Stripe::CardError, Stripe::RateLimitError, Stripe::InvalidRequestError, Stripe::AuthenticationError, Stripe::APIConnectionError, Stripe::StripeError => e
      flash[:error] = e.message
      Rails.logger.error "Payment failed with exception #{e} for parent #{@registration_cart.parent.first_name} #{@registration_cart.parent.last_name}"
    rescue => e
      flash[:error] = e.message
      Rails.logger.error "An error occurred while trying to make a payment #{e}"
    end

    def refund_payment(charge)
      if !is_charge_valid(charge) or charge.id == 0
        return
      end

      refund = Stripe::Refund.create(
          :charge => charge.id
      )

      Rails.logger.info 'A refund had to be made since an error happened after taking a payment'
      return refund
    rescue Stripe::CardError, Stripe::RateLimitError, Stripe::InvalidRequestError, Stripe::AuthenticationError, Stripe::APIConnectionError, Stripe::StripeError => e
      flash[:error] = 'Contact the camp for a refund of your payment'
      Rails.logger.error "Refund failed with exception #{e}"
    end

    def is_charge_valid(charge)
      !charge.nil? and charge.respond_to?('id')
    end
end
