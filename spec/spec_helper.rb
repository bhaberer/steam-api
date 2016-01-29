require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

if File::exist? File.join(File.dirname(__FILE__), "secret.rb")
  require 'secret'
end

require 'steam-api'
