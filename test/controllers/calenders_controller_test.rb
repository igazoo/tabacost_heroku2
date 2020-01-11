require 'test_helper'

class CalendersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calenders_index_url
    assert_response :success
  end

end
