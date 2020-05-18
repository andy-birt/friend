require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(email: "bob@bomb.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be a valid user" do
    assert @user.valid?, @user.errors.full_messages
  end

  test "email should not be empty" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be valid" do
    # Invalid email addresses
    %w{bob.com bob@wer @.com as.m@.g mail another@mail..com another@@mail.com}.each do |email|
      @user.email = email
      assert_not @user.valid?
    end
    # Valid email addresses
    %w{bob@bomb.com something@gmail.com jim1234@hotmail.com old@hughes.net}.each do |email|
      @user.email = email
      assert @user.valid?
    end
  end

  test "password should be valid" do
    # test empty is not valid
    @user.password = "      "
    @user.password_confirmation = "      "
    assert_not @user.valid?
    # test too short is not valid
    @user.password = "a" * 5
    @user.password_confirmation = "a" * 5
    assert_not @user.valid?
    # test too long is not valid
    @user.password = "a" * 129
    @user.password_confirmation = "a" * 129
    assert_not @user.valid?
    # test minimum characters is valid
    @user.password = "a" * 6
    @user.password_confirmation = "a" * 6
    assert @user.valid?
    # test maximum characters is valid
    @user.password = "a" * 128
    @user.password_confirmation = "a" * 128
    assert @user.valid?
  end

end
