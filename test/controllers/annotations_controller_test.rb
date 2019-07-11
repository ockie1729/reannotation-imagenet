require 'test_helper'

class AnnotationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get annotations_index_url
    assert_response :success
  end

end
