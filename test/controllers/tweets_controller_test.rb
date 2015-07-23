require "test_helper"

class TweetsControllerTest < ActionController::TestCase
  test "fetches tweets on create" do
    post :create, :tweet => "tweetin"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end
end
