# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steam-api/version'

Gem::Specification.new do |gem|
  gem.name          = 'steam-api'
  gem.version       = Steam::VERSION
  gem.authors       = ['Brian Haberer']
  gem.email         = ['bhaberer@gmail.com']
  gem.description   = %q{Simple Steam Gem}
  gem.summary       = %q{Simple Gem to interact witht the Steam Web API}
  gem.homepage      = 'https://github.com/bhaberer/steam-api'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake', '~> 10'
  gem.add_development_dependency 'rspec', '~> 3'
  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_dependency 'faraday', '0.9.0'
  gem.add_dependency 'multi_json', '~> 1.7', '>= 1.7.7'
  gem.add_dependency 'json', '~> 1.7', '>= 1.7.7'
end
