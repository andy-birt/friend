require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = Like.new(user_id: users(:alice).id, likable: posts(:one))
  end

  test "should be valid" do
    assert @like.valid?, @like.errors.messages
  end

  test "should have post_id" do
    @like.likable_id = nil
    assert_not @like.valid?
  end

  test "should have user_id" do
    @like.user_id = nil
    assert_not @like.valid?
  end
end
