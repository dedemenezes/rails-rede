begin
  require 'factory_bot_rails'
rescue LoadError
end
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
