require "factory_bot"

RSpec.configure do |config|
  # For Devise > 4.1.1
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Use the following instead if you are on Devise <= 4.1.1
  # config.include Devise::TestHelpers, :type => :controller
  config.include FactoryBot::Syntax::Methods
  config.extend ControllerMacros, type: :controller
  config.extend ControllerMacros, type: :request
end
