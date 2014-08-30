require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get change_overall" do
    get :change_overall
    assert_response :success
  end

  test "should get change_position" do
    get :change_position
    assert_response :success
  end

end
