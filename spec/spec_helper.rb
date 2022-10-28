require 'simplecov'
SimpleCov.start

if File::exist? File.join(File.dirname(__FILE__), "secret.rb")
  require 'secret'
end

require 'steam-api'

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/examples.txt'
end
