# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef/sugar/rackspace/version'

Gem::Specification.new do |spec|
  spec.name          = 'chef-sugar-rackspace'
  spec.version       = Chef::Sugar::Rackspace::VERSION
  spec.authors       = ['Jim Rosser']
  spec.email         = ['jarosser06@gmail.com']
  spec.description   = 'An extension to the "chef-sugar" gem with rackspace' \
                       ' specific helpers.'
  spec.summary       = 'A collection of helper methods and modules, extending' \
                       ' the helper methods available in the "chef-sugar" gem' \
                       ' for Rackspace.'
  spec.homepage      = 'https://github.com/jarosser06/chef-sugar-rackspace'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 1.9'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_runtime_dependency 'chef-sugar', '~> 2.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler',         '~> 1.3'
  spec.add_development_dependency 'chefspec',        '~> 4.2'
  spec.add_development_dependency 'test-kitchen',    '~> 1.3'
  spec.add_development_dependency 'kitchen-vagrant', '~> 0.15'
end
