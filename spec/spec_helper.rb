require 'coveralls'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

if File::exist? File.join(File.dirname(__FILE__), "secret.rb")
  require 'secret'
end

require 'steam-api'
