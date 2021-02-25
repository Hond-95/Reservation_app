require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get sing_in" do
    get users_sing_in_url
    assert_response :success
  end
end
