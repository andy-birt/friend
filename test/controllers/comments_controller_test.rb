require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
  end

  test "can't comment unless logged in" do
    get new_user_post_comment_path(@post.author, @post.id), xhr: true
    assert_response :unauthorized
  end
end
