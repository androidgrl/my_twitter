require "test_helper"
class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest

  test "logging out" do
    VCR.use_cassette("user-timeline") do
      visit "/"
      assert_equal 200, page.status_code
      click_on "Login"
      click_on "Logout"
      assert_equal "/", current_path
      assert page.has_link?("Login")
      refute page.has_link?("Logout")
      refute page.has_content?("Jamie")
    end
  end

  test "logging in" do
    VCR.use_cassette("user-timeline") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login"
      assert_equal "/", current_path
      assert page.has_content?("Jamie")
      assert page.has_link?("Logout")
      assert page.has_css?(".tweet")
    end
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "2579384508",
          name: "Jamie Kawahara",
          screen_name: "androidgrl",
        }
      },
      credentials: {
        token: ENV["SAMPLE_OAUTH_TOKEN"],
        secret: ENV["SAMPLE_OAUTH_SECRET"]
      }
    })
  end
end
