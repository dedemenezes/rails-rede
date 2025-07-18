require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
# require 'webmock/minitest'


class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # include Warden::Test::Helpers
  include Devise::Test::IntegrationHelpers

  # Sets ActiveStorage::Current.host for tests using local disk
  ActiveSupport.on_load :action_controller do
    include ActiveStorage::SetCurrent
  end
end
