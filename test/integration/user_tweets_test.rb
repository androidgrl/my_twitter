require "test_helper"
class UserTweetsTest < ActionDispatch::IntegrationTest

  test "tweeting" do
    VCR.use_cassette("tweeting-timeline") do
      visit "/"
      assert_equal 200, page.status_code
      click_on "Login"
      assert_equal "/", current_path
      assert page.has_content?("Jamie")
      within(".sweet-tweetin") do
        fill_in "Tweet", with: "Tweetin"
      end
      within(".my-submit-button") do
        click_button "Submit"
      end
      assert_equal "/", current_path
      within(".my-sweet-tweet") do
        assert page.has_content?("Tweetin")
      end
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
