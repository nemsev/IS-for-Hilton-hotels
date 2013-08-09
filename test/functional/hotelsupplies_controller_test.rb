require 'test_helper'

class HotelsuppliesControllerTest < ActionController::TestCase
  setup do
    @hotelsupply = hotelsupplies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hotelsupplies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hotelsupply" do
    assert_difference('Hotelsupply.count') do
      post :create, hotelsupply: { cost: @hotelsupply.cost, name: @hotelsupply.name, num: @hotelsupply.num }
    end

    assert_redirected_to hotelsupply_path(assigns(:hotelsupply))
  end

  test "should show hotelsupply" do
    get :show, id: @hotelsupply
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hotelsupply
    assert_response :success
  end

  test "should update hotelsupply" do
    put :update, id: @hotelsupply, hotelsupply: { cost: @hotelsupply.cost, name: @hotelsupply.name, num: @hotelsupply.num }
    assert_redirected_to hotelsupply_path(assigns(:hotelsupply))
  end

  test "should destroy hotelsupply" do
    assert_difference('Hotelsupply.count', -1) do
      delete :destroy, id: @hotelsupply
    end

    assert_redirected_to hotelsupplies_path
  end
end
