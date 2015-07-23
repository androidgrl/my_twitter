ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  fixtures :all
  #include Capybara::DSL

  #def setup
    #Capybara.app = MyTwitter::Application
    #stub_omniauth
  #end

  #def stub_omniauth
    #OmniAuth.config.test_mode = true
    #OmniAuth.config.mock_auth[:twitter] =
      #OmniAuth::AuthHash.new({
      #provider: 'twitter',
      #extra: {
        #raw_info: {
          #user_id: "1234",
          #name: "Jamie",
          #screen_name: "androidgrl"
        #}
      #},
      #credentials: {
        #token: "3dprint",
        #secret: "secret3dprint"
      #}
    #})
  #end
end
