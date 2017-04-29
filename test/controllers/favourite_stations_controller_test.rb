require 'test_helper'

class FavouriteStationsControllerTest < ActionController::TestCase
  setup do
    @favourite_station = favourite_stations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:favourite_stations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create favourite_station" do
    assert_difference('FavouriteStation.count') do
      post :create, favourite_station: { observation_station_id: @favourite_station.observation_station_id, user_id: @favourite_station.user_id }
    end

    assert_redirected_to favourite_station_path(assigns(:favourite_station))
  end

  test "should show favourite_station" do
    get :show, id: @favourite_station
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @favourite_station
    assert_response :success
  end

  test "should update favourite_station" do
    patch :update, id: @favourite_station, favourite_station: { observation_station_id: @favourite_station.observation_station_id, user_id: @favourite_station.user_id }
    assert_redirected_to favourite_station_path(assigns(:favourite_station))
  end

  test "should destroy favourite_station" do
    assert_difference('FavouriteStation.count', -1) do
      delete :destroy, id: @favourite_station
    end

    assert_redirected_to favourite_stations_path
  end
end
