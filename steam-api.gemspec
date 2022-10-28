# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steam-api/version'

Gem::Specification.new do |gem|
  gem.name          = 'steam-api'
  gem.version       = Steam::VERSION
  gem.authors       = ['Brian Haberer']
  gem.email         = ['bhaberer@gmail.com']
  gem.description   = 'Simple Steam Gem'
  gem.summary       = 'Simple Gem to interact with the Steam Web API'
  gem.homepage      = 'https://github.com/bhaberer/steam-api'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($RS)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'rspec', '~> 3.9'

  gem.add_dependency 'faraday', '~> 1.0'
end
