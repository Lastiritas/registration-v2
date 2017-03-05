class CampSessionsController < ApplicationController
  before_action :set_camp_session, only: [:show, :edit, :update, :destroy]

  # GET /camp_sessions
  # GET /camp_sessions.json
  def index
    @camp_sessions = CampSession.all
  end

  # GET /camp_sessions/1
  # GET /camp_sessions/1.json
  def show
  end

  # GET /camp_sessions/new
  def new
    @camp_session = CampSession.new
  end

  # GET /camp_sessions/1/edit
  def edit
  end

  # POST /camp_sessions
  # POST /camp_sessions.json
  def create
    @camp_session = CampSession.new(camp_session_params)

    respond_to do |format|
      if @camp_session.save
        format.html { redirect_to @camp_session, notice: 'Camp session was successfully created.' }
        format.json { render :show, status: :created, location: @camp_session }
      else
        format.html { render :new }
        format.json { render json: @camp_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camp_sessions/1
  # PATCH/PUT /camp_sessions/1.json
  def update
    respond_to do |format|
      if @camp_session.update(camp_session_params)
        format.html { redirect_to @camp_session, notice: 'Camp session was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp_session }
      else
        format.html { render :edit }
        format.json { render json: @camp_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camp_sessions/1
  # DELETE /camp_sessions/1.json
  def destroy
    if CampSession.ensure_not_referenced_by_any_camper
      @camp_session.destroy
      respond_to do |format|
        format.html { redirect_to camp_sessions_url, notice: 'Camp session was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp_session
      @camp_session = CampSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camp_session_params
      params.require(:camp_session).permit(:name, :capacity, :start_date, :end_date, :year, :remaining, :gender, :fee, :minimum_age, :maximum_age, :enabled)
    end
end
