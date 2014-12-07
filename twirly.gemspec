# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twirly/version'

Gem::Specification.new do |spec|
  spec.name          = 'twirly'
  spec.version       = Twirly::VERSION
  spec.authors       = ['Dimitris Zorbas']
  spec.email         = ['zorbash@skroutz.gr']
  spec.description   = <<-DESC
  Publishing platform using trello
  DESC

  spec.summary       = %q{Publishing platform using trello}
  spec.homepage      = 'https://github.com/Zorbash/twirly'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'fakefs'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'factory_girl'

  spec.add_dependency 'awesome_print'
  spec.add_dependency 'thor'
  spec.add_dependency 'ruby-trello'
  spec.add_dependency 'liquid'
  spec.add_dependency 'json', '~> 1.8.1'
end
