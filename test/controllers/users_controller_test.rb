require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:jim)
    @other_user = users(:frank)
  end
  
  test "should redirect index if not signed in" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should get user index if authenticated" do
    sign_in @user
    get users_path
    assert_response :success
  end

  test "should redirect show if not signed in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

end
