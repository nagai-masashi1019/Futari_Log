require "test_helper"

class CoupleSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get couple_settings_show_url
    assert_response :success
  end

  test "should get update" do
    get couple_settings_update_url
    assert_response :success
  end
end
