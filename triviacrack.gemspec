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
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "rspec-its", "~> 1.2.0"
  spec.add_development_dependency "json", "~> 1.8.2"

  spec.add_dependency "unirest", "~> 1.1.2"
end
