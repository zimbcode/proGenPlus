require 'test_helper'

class ProtocolsControllerTest < ActionController::TestCase
  setup do
    @protocol = protocols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:protocols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create protocol" do
    assert_difference('Protocol.count') do
      post :create, params: { protocol: { creator: @protocol.creator, dateCreated: @protocol.dateCreated, dateSent: @protocol.dateSent, text: @protocol.text } }
    end

    assert_redirected_to protocol_path(assigns(:protocol))
  end

  test "should show protocol" do
    get :show, params: { id: @protocol }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @protocol }
    assert_response :success
  end

  test "should update protocol" do
    patch :update, params: {id: @protocol, protocol: { creator: @protocol.creator, dateCreated: @protocol.dateCreated, dateSent: @protocol.dateSent, text: @protocol.text } }
    assert_redirected_to protocol_path(assigns(:protocol))
  end

  test "should destroy protocol" do
    assert_difference('Protocol.count', -1) do
      delete :destroy, params: { id: @protocol }
    end

    assert_redirected_to protocols_path
  end
end
