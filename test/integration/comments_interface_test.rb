require 'test_helper'

class CommentsInterfaceTest < ActionDispatch::IntegrationTest
  
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:alice)
    @jim = users(:jim)
    @post = posts(:one)
  end

  test "comment interface" do
    sign_in @user
    get authenticated_root_path
    assert_select "div.pagination"
    assert_select "button", text: "Comment"
    # invalid comment
    assert_no_difference "Comment.count" do
      post user_post_comments_path(@jim, @post), params: { comment: { user_id: @user.id, body: "" } }, xhr: true
    end
    # valid comment
    content = "A wonderful comment!"
    assert_difference "Comment.count", 1 do
      post user_post_comments_path(@jim, @post), params: { comment: { user_id: @user.id, body: content } }, xhr: true
    end
    assert_match content, response.body
    # update comment
    content = "An updated comment!"
    assert_no_difference "Comment.count" do
      patch user_post_comment_path(@jim, @post, @post.comments.first), params: { comment: { user_id: @user.id, body: content } }
      assert_response :redirect
      follow_redirect!
      assert_match content, @post.comments.first.body
    end
    # delete comment
    assert_difference "Comment.count", -1 do
      delete user_post_comment_path(@jim, @post, @post.comments.first)
    end
    
  end

end