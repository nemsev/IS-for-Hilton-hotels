require 'test_helper'

class TaxirequestsControllerTest < ActionController::TestCase
  setup do
    @taxirequest = taxirequests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxirequests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taxirequest" do
    assert_difference('Taxirequest.count') do
      post :create, taxirequest: {  }
    end

    assert_redirected_to taxirequest_path(assigns(:taxirequest))
  end

  test "should show taxirequest" do
    get :show, id: @taxirequest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @taxirequest
    assert_response :success
  end

  test "should update taxirequest" do
    put :update, id: @taxirequest, taxirequest: {  }
    assert_redirected_to taxirequest_path(assigns(:taxirequest))
  end

  test "should destroy taxirequest" do
    assert_difference('Taxirequest.count', -1) do
      delete :destroy, id: @taxirequest
    end

    assert_redirected_to taxirequests_path
  end
end
