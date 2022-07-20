# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'triviacrack/version'

Gem::Specification.new do |spec|
  spec.name          = 'triviacrack'
  spec.version       = TriviaCrack::VERSION
  spec.authors       = ['David Kus']
  spec.email         = ['david@kus.dk']
  spec.summary       = 'A Ruby interface to the Trivia Crack API.'
  spec.description   = 'A Ruby interface to the Trivia Crack API.'
  spec.homepage      = 'https://github.com/davidkus/triviacrack'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5'

  spec.add_development_dependency 'bundler', '~> 2.3.18'
  spec.add_development_dependency 'fuubar', '~> 2.5.1'
  spec.add_development_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'rspec', '~> 3.11.0'
  spec.add_development_dependency 'rspec-its', '~> 1.3.0'
  spec.add_development_dependency 'rubocop', '~> 1.31.2'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'

  spec.add_dependency 'faraday', '~> 2.3.0'
  spec.add_dependency 'json', '~> 2.6.2'
end
