require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  
  def setup
    @fr = FriendRequest.new(user: users(:jim), receiver: users(:frank), accepted: nil)
  end

  test "should be valid" do
    assert @fr.valid?, @fr.errors.full_messages
  end

  test "user must exist (a sender)" do
    @fr.user = nil
    assert_not @fr.valid?
  end

  test "receiver must exist" do
    @fr.receiver = nil
    assert_not @fr.valid?
  end

end
