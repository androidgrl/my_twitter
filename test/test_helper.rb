ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'mocha/mini_test'
require 'vcr'
require 'simplecov'
SimpleCov.start 'rails'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :serialize_with => :json }
  c.before_record do |r|
    r.request.headers.delete("Authorization")
  end
end

class ActiveSupport::TestCase
  fixtures :all
  include Capybara::DSL

  def setup
    Capybara.app = MyTwitter::Application
    stub_omniauth
  end
end
