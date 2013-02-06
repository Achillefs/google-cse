require 'google_cse'

RSpec.configure do |config|
  Dir[File.join(File.dirname(__FILE__),'spec','support''**','*.rb')].each {|f| require f}
  config.mock_with :rspec
  config.order = "random"
end

GoogleCSE::CX = 'cse-identifier'
GoogleCSE::KEY = 'custom-search-key'