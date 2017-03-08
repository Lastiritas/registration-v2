require 'date'
class CampersController < ApplicationController
  include CurrentRegistrationCart
  before_action :require_log_in
  before_action :validate_parent_is_set_under_registration_cart
  before_action :set_camper, only: [:edit, :update, :destroy]
  before_action :set_sessions, except: [:destroy]

  # GET /campers/new
  def new
    @camper = Camper.new
  end

  # GET /campers/1/edit
  def edit
  end

  # POST /campers
  # POST /campers.json
  def create
    @camper = Camper.new(camper_params)
    @camper.registration_cart = @registration_cart
    @camper.parent = @registration_cart.parent

    date = nil
    begin
      date = DateTime.parse(camper_params[:birth_date])
    rescue ArgumentError => e
      logger.info "Date Time conversion failed #{e}"
    end

    respond_to do |format|
      # Now make sure the camper age is allowed for the chosen camp session
      if @camper.invalid? or !CampSession.session_valid_for_camper?(date, camper_params[:camp_session_id])
        flash.now[:error] = "Please select the week that corresponds to the camper's age"
        format.html { render :new }
      elsif @camper.save
        format.html { redirect_to registration_cart_path(@registration_cart.id) }
      else
        format.html { render :new }
        format.json { render json: @camper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campers/1
  # PATCH/PUT /campers/1.json
  def update
    respond_to do |format|
      if @camper.update(camper_params)
        format.html { redirect_to registration_cart_path(@registration_cart.id) }
      else
        format.html { render :edit }
        format.json { render json: @camper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campers/1
  # DELETE /campers/1.json
  def destroy
    @camper.registration_cart = nil
    @camper.camp_session = nil
    @camper.save(validate: false)
    respond_to do |format|
      format.html { redirect_to registration_cart_path(@registration_cart.id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camper
      @camper = Camper.find(params[:id])
    end

    def set_sessions
      @camp_sessions = CampSession.where(enabled: true)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camper_params
      params.require(:camper).permit(:camp_session_id, :registration_cart_id, :first_name, :last_name, :gender, :address, :birth_date)
    end
end
