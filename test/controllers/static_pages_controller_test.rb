require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers
  
  test "user must sign in before using site" do
    get "/"
    assert_response :success
    assert_select "h2", "Sign up"
  end

  test "signed in user can access sites content" do
    # Sign in user then follow root path get home page
    sign_in users(:jim)
    get "/"
    assert_response :success
    assert_select "h1", "Welcome jim@pew.com"
    # Sign out user then follow root path get sign up/log in page
    sign_out users(:jim)
    get "/"
    assert_response :success
    assert_select "h2", "Sign up"
  end

end
