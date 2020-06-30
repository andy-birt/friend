require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @notification = Notification.new(receiver_id: users(:alice).id, 
                                      actor_id: users(:frank).id, 
                                      notifiable_id: friend_requests(:frank_alice).id, 
                                      notifiable_type: "FriendRequest")
  end

  test "should be valid?" do
    assert @notification.valid?
  end

  test "should have receiver" do
    @notification.receiver = nil
    assert_not @notification.valid?
  end

  test "should have actor" do
    @notification.actor = nil
    assert_not @notification.valid?
  end

  test "should have notifiable object" do
    @notification.notifiable = nil
    assert_not @notification.valid?
  end
end
