class DailyObservationsController < ApplicationController
  before_action :set_daily_observation, only: [:show, :edit, :update, :destroy]

  # GET /daily_observations
  # GET /daily_observations.json
  def index
    @daily_observations = DailyObservation.where(date: Date.today)
  end

  # GET /daily_observations/1
  # GET /daily_observations/1.json
  def show
  end

  # GET /daily_observations/new
  def new
    # @daily_observation = DailyObservation.new
  end

  # GET /daily_observations/1/edit
  def edit
  end

  # DELETE /daily_observations/1
  # DELETE /daily_observations/1.json
  def destroy
    # @daily_observation.destroy
    # respond_to do |format|
    #   format.html { redirect_to daily_observations_url, notice: 'Daily observation was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def fetch_daily_temperatures
    FmiObservations.fetch_daily_temperatures_from_all_stations
    redirect_to :back, notice:"Todays temperatures updated."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_observation
      @daily_observation = DailyObservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_observation_params
      params.require(:daily_observation).permit(:observation_station_id, :date, :t2max, :t2maxtime, :t2min, :t2mintime)
    end
end
