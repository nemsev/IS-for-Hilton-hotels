require 'test_helper'

class StationeryrequestsControllerTest < ActionController::TestCase
  setup do
    @stationeryrequest = stationeryrequests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stationeryrequests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stationeryrequest" do
    assert_difference('Stationeryrequest.count') do
      post :create, stationeryrequest: { status: @stationeryrequest.status }
    end

    assert_redirected_to stationeryrequest_path(assigns(:stationeryrequest))
  end

  test "should show stationeryrequest" do
    get :show, id: @stationeryrequest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stationeryrequest
    assert_response :success
  end

  test "should update stationeryrequest" do
    put :update, id: @stationeryrequest, stationeryrequest: { status: @stationeryrequest.status }
    assert_redirected_to stationeryrequest_path(assigns(:stationeryrequest))
  end

  test "should destroy stationeryrequest" do
    assert_difference('Stationeryrequest.count', -1) do
      delete :destroy, id: @stationeryrequest
    end

    assert_redirected_to stationeryrequests_path
  end
end
