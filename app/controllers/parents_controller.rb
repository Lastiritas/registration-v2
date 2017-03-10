class ParentsController < ApplicationController
  include CurrentRegistrationCart
  before_action :require_log_in
  before_action :set_or_create_registration_cart, only: [:create, :show, :update]
  before_action :validate_parent_is_set_under_registration_cart, only: [:edit]
  before_action :set_parent, only: [:show, :edit, :update]

  # GET /parents
  # GET /parents.json
  def index
    @submissions = Submission.where(user: current_user).or(Submission.where(email: current_user.email))
  end

  # GET /parents/1
  # GET /parents/1.json
  def show
  end

  # GET /parents/new
  def new
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  # POST /parents.json
  def create
    @parent = Parent.new(parent_params)
    @parent.registration_cart = @registration_cart
    @parent.user = current_user

    respond_to do |format|
      if @parent.save
        format.html { redirect_to new_camper_path }
        format.json { render :show, status: :created, location: @parent }
      else
        format.html { render :new }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parents/1
  # PATCH/PUT /parents/1.json
  def update
    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to registration_cart_path(@registration_cart.id) }
        format.json { render :show, status: :ok, location: @parent }
      else
        format.html { render :edit }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_params
      params.require(:parent).permit(:first_name, :last_name, :address, :email, :home_phone_number, :cell_phone_number, :work_phone_number)
    end
end
