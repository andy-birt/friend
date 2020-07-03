require 'test_helper'

class FriendRequestInterfaceTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers
  
  def setup
    @jim = users(:jim)
    @frank = users(:frank)
    @alice = users(:alice)
    @fr = friend_requests(:jim_frank)
    @friends = friend_requests(:two)
  end

  
  test "friend requests" do
    
    # Jim has a friend request sent to frank already so test for that request
    assert_not @jim.friend_requests.empty?

    # Frank has not sent any requests so test that he has none
    assert @frank.friend_requests.empty?

  end

  test "cancel a friend request" do
    
    sign_in @jim
    get users_path
    assert_select "a[href=?]", friend_requests_path(user_id: @fr.user.id, receiver_id: @fr.receiver.id)
    assert_difference "@jim.friend_requests.count", -1 do
      delete friend_requests_path(user_id: @fr.user.id, receiver_id: @fr.receiver.id)
      assert_equal "Cancelled friend request", flash[:success]
      assert_response :redirect
      follow_redirect!
      assert_equal "/", path
    end
    assert_equal @frank.notifications.count, 0

  end

  test "decline a friend request" do
  
    sign_in @frank
    get users_path
    assert_select "a[href=?]", friend_requests_path(user_id: @fr.user.id, receiver_id: @fr.receiver.id)
    assert_difference "@jim.friend_requests.count", -1 do
      delete friend_requests_path(user_id: @fr.user_id, receiver_id: @fr.receiver_id)
      assert_equal "Declined friend request", flash[:success]
      assert_response :redirect
      follow_redirect!
      assert_equal "/", path
    end
    assert_equal @frank.notifications.count, 0

  end

  test "send a friend request" do
    
    # Destroy all friend requests and notifications to start a clean slate
    @frank.notifications.destroy_all
    @jim.friend_requests.destroy_all
    assert @jim.friend_requests.empty?

    sign_in @jim
    get users_path
    assert_select "a[href=?]", friend_requests_path(user_id: @frank.id)
    assert_difference "@jim.friend_requests.count" do
      post friend_requests_path, params: { user_id: @frank.id }
      assert_equal "Friend request has been sent", flash[:info]
      assert_response :redirect
      follow_redirect!
      assert_equal "/", path
    end
    assert_equal @frank.notifications.count, 1
    sign_out @jim
    # Make sure frank got notified of friend request
    sign_in @frank
    get notifications_path
    assert_match "#{@jim.full_name} sent you a friend request", response.body
  end

  test "accept a friend request" do
    
    sign_in @frank
    get users_path
    assert_select "a[href=?]", friend_requests_path(user_id: @jim.id, receiver_id: @frank.id)
    assert_difference "@jim.friends.count" do
      post friend_requests_path, params: { user_id: @jim.id }
      assert_equal "You are now friends with #{@jim.full_name}", flash[:success]
      assert_response :redirect
      follow_redirect!
      assert_equal "/", path
    end
    assert_equal @frank.notifications.count, 0

  end

  test "unfriend a friend" do
  
    sign_in @alice
    get users_path
    assert_select "a[href=?]", friend_requests_path(user_id: @jim.id)
    assert_equal @jim.friends.count, 1
    assert_difference "@alice.friends.count", -1 do
      delete friend_requests_path(user_id: @jim.id)
      assert_equal "You have unfriended #{@jim.full_name}", flash[:success]
      assert_response :redirect
      follow_redirect!
      assert_equal "/", path
    end
    assert_equal @jim.friends.count, 0

  end


end
