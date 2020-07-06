require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
  
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:alice)
  end

  test "post interface" do
    sign_in @user
    get authenticated_root_path
    assert_select "div.pagination"
    # invalid post
    assert_no_difference "Post.count" do
      post user_posts_path(@user.id), params: { post: { body: "" } }
    end
    # valid post
    content = "A wonderful post!"
    assert_difference "Post.count", 1 do
      post user_posts_path(@user.id), params: { post: { body: content } }
    end
    assert_redirected_to authenticated_root_path
    follow_redirect!
    assert_match content, response.body
    # update post
    content = "An updated post!"
    assert_select "a", text: "Edit Post"
    assert_no_difference "Post.count" do
      patch user_post_path(@user.id, @user.posts.first.id), params: { post: { body: content } }
    end
    assert_redirected_to authenticated_root_path
    follow_redirect!
    assert_match content, response.body
    # delete post
    assert_select "a", text: "Delete Post"
    assert_difference "Post.count", -1 do
      delete user_post_path(@user, @user.posts.first)
    end
    # Visit another user
    get user_path(users(:jim).id)
    assert_select "a", text: "Delete Post", count: 0
  end

end