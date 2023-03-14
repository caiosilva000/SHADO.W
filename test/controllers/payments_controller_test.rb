require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get pay" do
    get payments_pay_url
    assert_response :success
  end
end
