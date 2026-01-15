require "test_helper"

class Couples::OnboardingControllerTest < ActionDispatch::IntegrationTest
  test "should get choice" do
    get couples_onboarding_choice_url
    assert_response :success
  end
end
