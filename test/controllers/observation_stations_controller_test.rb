require 'test_helper'

class ObservationStationsControllerTest < ActionController::TestCase
  setup do
    @observation_station = observation_stations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:observation_stations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create observation_station" do
    assert_difference('ObservationStation.count') do
      post :create, observation_station: { elevation: @observation_station.elevation, fmisid: @observation_station.fmisid, group: @observation_station.group, lat: @observation_station.lat, lon: @observation_station.lon, lpnn: @observation_station.lpnn, name: @observation_station.name, wmo: @observation_station.wmo, year: @observation_station.year }
    end

    assert_redirected_to observation_station_path(assigns(:observation_station))
  end

  test "should show observation_station" do
    get :show, id: @observation_station
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @observation_station
    assert_response :success
  end

  test "should update observation_station" do
    patch :update, id: @observation_station, observation_station: { elevation: @observation_station.elevation, fmisid: @observation_station.fmisid, group: @observation_station.group, lat: @observation_station.lat, lon: @observation_station.lon, lpnn: @observation_station.lpnn, name: @observation_station.name, wmo: @observation_station.wmo, year: @observation_station.year }
    assert_redirected_to observation_station_path(assigns(:observation_station))
  end

  test "should destroy observation_station" do
    assert_difference('ObservationStation.count', -1) do
      delete :destroy, id: @observation_station
    end

    assert_redirected_to observation_stations_path
  end
end
