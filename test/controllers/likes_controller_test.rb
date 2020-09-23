require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  test "create should be required logged_in" do
    assert_no_difference "Like.count" do
      post like_path
    end   
     assert_redirect_to login_url
  end
  
  test "destroy should be required logged_in" do
    assert_no_difference "Like.count" do
      delete like_path(likes(:one))
    end
    assert_redirected_to login_url
  end
end
