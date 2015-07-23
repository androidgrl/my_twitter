require "test_helper"
class UserFavoritesATweetTest < ActionDispatch::IntegrationTest

  test "favorites a tweet" do
    VCR.use_cassette("favorite-timeline") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login"
      assert_equal "/", current_path
      assert page.has_content?("Jamie")
      assert page.has_link?("Logout")
      assert page.has_css?(".tweet")
      within("#624255543008489472") do
        click_button "favorite"
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
