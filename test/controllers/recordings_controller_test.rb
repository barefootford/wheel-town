require "test_helper"

class RecordingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get recordings_new_url
    assert_response :success
  end

  test "should get create" do
    get recordings_create_url
    assert_response :success
  end
end
