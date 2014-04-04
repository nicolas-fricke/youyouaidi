# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'youyouaidi/version'

Gem::Specification.new do |spec|
  spec.name          = 'youyouaidi'
  spec.version       = Youyouaidi::VERSION
  spec.authors       = ['Nicolas Fricke']
  spec.email         = ['mail@nicolasfricke.de']
  spec.summary       = %q{UUID class}
  spec.description   = %q{Youyouaidi offers a UUID class for parsing, validating and encoding UUIDs}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
