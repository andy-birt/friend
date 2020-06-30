require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:jim)
    @post = posts(:one)
  end

  test "should redirect actions if not logged in" do
    # index
    get user_posts_path(@user.id)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
    # create
    post user_posts_path(@user.id)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
    # new
    get new_user_post_path(@user.id)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
    # edit
    get edit_user_post_path(@user.id, @post.id)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
    # show
    get user_post_path(@user.id, @post.id)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
    # update
    patch user_post_path(@user.id, @post.id)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
    # destroy
    delete user_post_path(@user.id, @post.id)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should get index when authenticated" do
    sign_in @user
    get user_posts_path(@user.id)
    assert_response :success
  end

  test "should get show when authenticated" do
    sign_in @user
    get user_post_path(@user.id, @post.id)
    assert_response :success
  end

end
