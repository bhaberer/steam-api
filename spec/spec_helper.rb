# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative 'secret' if File.exist? File.join(__dir__, 'secret.rb')

require_relative '../lib/steam-api'

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/examples.txt'
end
