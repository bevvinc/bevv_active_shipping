# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'solidus_active_shipping/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'solidus_active_shipping'
  s.version     = SolidusActiveShipping::VERSION
  s.author      = ['Solidus Team']
  s.email       = 'contact@solidus.io'
  s.homepage = 'https://github.com/bevvinc/solidus_active_shipping'
  s.summary     = 'Solidus extension for the active_shipping plugin.'
  s.description = 'Provide shipping rates and tracking for Active Merchant carriers'

  s.required_ruby_version = Gem::Requirement.new('~> 2.5')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  solidus_version = ['> 1.0', '< 3']

  s.add_dependency 'solidus_core', solidus_version
  s.add_dependency 'solidus_support', '~> 0.5'
  s.add_dependency 'solidus_backend', solidus_version
  s.add_dependency 'solidus_api', solidus_version
  s.add_dependency 'active_shipping', '~> 2.1.1'

  s.add_development_dependency 'solidus_dev_support', '~> 2.1'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
