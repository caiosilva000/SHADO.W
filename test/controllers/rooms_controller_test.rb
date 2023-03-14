require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get indx" do
    get rooms_indx_url
    assert_response :success
  end
end
