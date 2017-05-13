class ObservationStationsController < ApplicationController
  before_action :set_observation_station, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, only: [:create, :edit, :update, :destroy]

  # GET /observation_stations
  # GET /observation_stations.json
  def index
    #@observation_stations = ObservationStation.all
    @observation_stations = ObservationStation.paginate(:page => params[:page], :per_page => 50)
  end

  # GET /observation_stations/1
  # GET /observation_stations/1.json
  def show
    @favourite_stations = FavouriteStation.where(observation_station_id: @observation_station.id)

    if current_user and current_user.favourites.include? @observation_station
      @favourite_station = FavouriteStation.find_by ({user_id: current_user.id, observation_station: @observation_station})
    else
      @favourite_station = FavouriteStation.new
      @favourite_station.observation_station = @observation_station
    end
  end

  # Check if there are some new stations available
  def fetch_stations
    @new_stations = FmiStations.fetch_stations
    redirect_to :back, notice:"Observation stations updated according to latest available info."
  end

  def fetch_observations
    @new_observations = FmiObservations.fetch_all_observations(params[:fmisid])
    redirect_to :back, notice:"Observations updated."
  end

  def fetch_all_observations
    FmiObservations.fetch_observations_from_all_stations
    redirect_to :back, notice:"Todays observations updated."
  end

  # GET /observation_stations/new
  # def new
  #   @observation_station = ObservationStation.new
  # end

  # GET /observation_stations/1/edit
  def edit
  end

  # POST /observation_stations
  # POST /observation_stations.json
  # Stations are created with FmiApi
  def create
    # @observation_station = ObservationStation.new(observation_station_params)
    #
    # respond_to do |format|
    #   if @observation_station.save
    #     format.html { redirect_to @observation_station, notice: 'Observation station was successfully created.' }
    #     format.json { render :show, status: :created, location: @observation_station }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @observation_station.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /observation_stations/1
  # PATCH/PUT /observation_stations/1.json
  # Stations are updated with FmiApi
  def update
    # respond_to do |format|
    #   if @observation_station.update(observation_station_params)
    #     format.html { redirect_to @observation_station, notice: 'Observation station was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @observation_station }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @observation_station.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /observation_stations/1
  # DELETE /observation_stations/1.json
  # Will be added later for admins
  def destroy
    # @observation_station.destroy
    # respond_to do |format|
    #   format.html { redirect_to observation_stations_url, notice: 'Observation station was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observation_station
      @observation_station = ObservationStation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observation_station_params
      params.require(:observation_station).permit(:id, :lpnn, :wmo, :name, :year, :lat, :lon, :elevation, :group)
    end

end
