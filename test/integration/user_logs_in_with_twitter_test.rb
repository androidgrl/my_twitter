require "test_helper"
class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_on "Login"

    assert_equal "/", current_path
    assert page.has_content?("Jamie")
    assert page.has_link?("Logout")
  end

  test "logging out" do
    visit "/"
    assert_equal 200, page.status_code
    click_on "Login"
    click_on "Logout"
    assert_equal "/", current_path
    assert page.has_link?("Login")
    refute page.has_link?("Logout")
    refute page.has_content?("Jamie")
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] =
      OmniAuth::AuthHash.new({
        provider: 'twitter',
        extra: {
          raw_info: {
            user_id: "1234",
            name: "Jamie",
            screen_name: "androidgrl"
          }
        },
        credentials: {
          token: "3dprint",
          secret: "secret3dprint"
        }
    })
  end
end
