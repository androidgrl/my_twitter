ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'

class ActiveSupport::TestCase
  fixtures :all
  include Capybara::DSL

  def setup
    Capybara.app = MyTwitter::Application
    stub_omniauth
  end
end
