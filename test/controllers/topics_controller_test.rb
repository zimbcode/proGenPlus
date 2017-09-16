require 'pp'
require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @topic = topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic" do
    assert_difference('Topic.count') do
      pp @topic
      post :create, params: { protocol_id: @topic.protocol_id, topic: { headline: @topic.headline, text: @topic.text } }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should show topic" do
    get :show, params: { id: @topic }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @topic }
    assert_response :success
  end

  test "should update topic" do
    patch :update, params: { id: @topic, topic: { headline: @topic.headline, protocol_id: @topic.protocol_id, text: @topic.text } }
    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should destroy topic" do
    assert_difference('Topic.count', -1) do
      delete :destroy, params: { id: @topic }
    end

    assert_redirected_to topics_path
  end
end
