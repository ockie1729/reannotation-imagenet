require 'test_helper'

class EntrancePageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get entrance_page_index_url
    assert_response :success
  end

end
