require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get reservations_confirm_url
    assert_response :success
  end
end
