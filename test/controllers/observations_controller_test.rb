require 'test_helper'

class ObservationsControllerTest < ActionController::TestCase
  setup do
    @observation = observations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:observations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create observation" do
    assert_difference('Observation.count') do
      post :create, observation: { fmisid: @observation.fmisid, n: @observation.n, p_sea: @observation.p_sea, r_1h: @observation.r_1h, rh: @observation.rh, ri_10min: @observation.ri_10min, snow_aws: @observation.snow_aws, t2m: @observation.t2m, td: @observation.td, time: @observation.time, vis: @observation.vis, wawa: @observation.wawa, wd_10min: @observation.wd_10min, wg_10min: @observation.wg_10min, ws_10min: @observation.ws_10min }
    end

    assert_redirected_to observation_path(assigns(:observation))
  end

  test "should show observation" do
    get :show, id: @observation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @observation
    assert_response :success
  end

  test "should update observation" do
    patch :update, id: @observation, observation: { fmisid: @observation.fmisid, n: @observation.n, p_sea: @observation.p_sea, r_1h: @observation.r_1h, rh: @observation.rh, ri_10min: @observation.ri_10min, snow_aws: @observation.snow_aws, t2m: @observation.t2m, td: @observation.td, time: @observation.time, vis: @observation.vis, wawa: @observation.wawa, wd_10min: @observation.wd_10min, wg_10min: @observation.wg_10min, ws_10min: @observation.ws_10min }
    assert_redirected_to observation_path(assigns(:observation))
  end

  test "should destroy observation" do
    assert_difference('Observation.count', -1) do
      delete :destroy, id: @observation
    end

    assert_redirected_to observations_path
  end
end
