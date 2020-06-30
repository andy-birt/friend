require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(author: users(:jim), body: "posty!")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "body should not be empty" do
    @post.body = " "
    assert_not @post.valid?
  end

  test "author should be present" do
    @post.author = nil
    assert_not @post.valid?
  end
end
