require 'test_helper'

class PortscansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get portscans_index_url
    assert_response :success
  end

end
