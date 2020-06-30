require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect create when not logged in" do
    post user_post_likes_path(users(:alice).id, posts(:one).id)
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    delete user_post_like_path(users(:alice).id, posts(:one).id, likes(:one).id)
    assert_redirected_to new_user_session_path
  end
end
