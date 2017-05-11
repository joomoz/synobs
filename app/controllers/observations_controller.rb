class ObservationsController < ApplicationController
  require 'will_paginate/array'
  before_action :set_observation, only: [:show, :edit, :update, :destroy]

  # GET /observations
  # GET /observations.json
  def index
    @observations = Observation.all
  end

  # GET /observations/1
  # GET /observations/1.json
  def show
    @observations = Observation.all#.paginate(:page => params[:page], :per_page => 50)
  end

  # GET /observations/new
  def new
    # @observation = Observation.new
    # FmiObservations.fetch_observations("100968")
  end

  # DELETE /observations/1
  # DELETE /observations/1.json
  # This option Will be added for admin
  def destroy
    # @observation.destroy
    # respond_to do |format|
    #   format.html { redirect_to observations_url, notice: 'Observation was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observation
      @observation = Observation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observation_params
      params.require(:observation).permit(:observation_station_id, :time, :t2m, :td, :ws_10min, :wg_10min, :wd_10min, :rh, :r_1h, :ri_10min, :snow_aws, :p_sea, :vis, :n, :wawa)
    end
end
