# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'triviacrack/version'

Gem::Specification.new do |spec|
  spec.name          = "triviacrack"
  spec.version       = TriviaCrack::VERSION
  spec.authors       = ["David Kus"]
  spec.email         = ["david@kus.dk"]
  spec.summary       = %q{A Ruby interface to the Trivia Crack API.}
  spec.description   = %q{A Ruby interface to the Trivia Crack API.}
  spec.homepage      = "https://github.com/davidkus/triviacrack"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "simplecov", "~> 0.18.3"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "rspec", "~> 3.9.0"
  spec.add_development_dependency "rspec-its", "~> 1.3.0"
  spec.add_development_dependency "json", "~> 2.3.0"
  spec.add_development_dependency "fuubar", "~> 2.5.0"

  spec.add_dependency "unirest-2x", "~> 1.1.3"
end
