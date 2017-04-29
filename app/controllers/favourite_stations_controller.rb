class FavouriteStationsController < ApplicationController
  before_action :set_favourite_station, only: [:show, :edit, :update, :destroy]

  # GET /favourite_stations
  # GET /favourite_stations.json
  def index
    @favourite_stations = FavouriteStation.all
  end

  # GET /favourite_stations/1
  # GET /favourite_stations/1.json
  def show
  end

  # GET /favourite_stations/new
  def new
    @favourite_station = FavouriteStation.new
    @observation_stations = ObservationStation.all - current_user.favourites
  end

  # GET /favourite_stations/1/edit
  def edit
    @observation_stations = ObservationStation.all
  end

  # POST /favourite_stations
  # POST /favourite_stations.json
  def create
    @favourite_station = FavouriteStation.new(favourite_station_params)

    respond_to do |format|
      if current_user.nil?
        redirect_to signin_path, notice:'You have to be signed in!'
      elsif @favourite_station.save
        current_user.favourite_stations << @favourite_station
        format.html { redirect_to root_path, notice: 'Favourite station was successfully created.' }
        format.json { render :show, status: :created, location: @favourite_station }
      else
        @observation_stations = ObservationStation.all
        format.html { render :new }
        format.json { render json: @favourite_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favourite_stations/1
  # PATCH/PUT /favourite_stations/1.json
  def update
    respond_to do |format|
      if @favourite_station.update(favourite_station_params)
        format.html { redirect_to @favourite_station, notice: 'Favourite station was successfully updated.' }
        format.json { render :show, status: :ok, location: @favourite_station }
      else
        format.html { render :edit }
        format.json { render json: @favourite_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favourite_stations/1
  # DELETE /favourite_stations/1.json
  def destroy
    @favourite_station.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Favourite station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favourite_station
      @favourite_station = FavouriteStation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favourite_station_params
      params.require(:favourite_station).permit(:observation_station_id, :user_id)
    end
end
