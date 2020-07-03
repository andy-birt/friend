require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @jim = users(:jim)
  end
  
  test "friend_requests#create should redirect to login when not logged in" do
    post friend_requests_path, params: { user_id: @jim.id }
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  test "friend_requests#destroy should redirect to login when not logged in" do
    delete friend_requests_path, params: { user_id: @jim.id }
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end
end
