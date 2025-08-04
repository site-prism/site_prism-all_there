# frozen_string_literal: true

require './lib/site_prism/all_there/version'

Gem::Specification.new do |s|
  s.name        = 'site_prism-all_there'
  s.version     = SitePrism::AllThere::VERSION
  s.required_ruby_version = '>= 2.7'
  s.platform    = Gem::Platform::RUBY
  s.license     = 'BSD-3-Clause'
  s.authors     = ['Luke Hill']
  s.email       = %w[lukehill_uk@hotmail.com]
  s.homepage    = 'https://github.com/site-prism/site_prism-all_there'
  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/site-prism/site_prism-all_there/issues',
    'changelog_uri' => 'https://github.com/site-prism/site_prism-all_there/blob/main/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/site-prism/site_prism-all_there'
  }
  s.summary     = 'An extension to SitePrism that enables you to recurse through SitePrism Pages and Sections'
  s.description = 'SitePrism AllThere allows you to recursively query page and section structures
on your page - exclusively for use with the SitePrism gem.'
  s.files        = Dir.glob('lib/**/*') + %w[LICENSE.md README.md]
  s.require_path = 'lib'

  s.add_development_dependency 'rspec', '~> 3.13'
  s.add_development_dependency 'rubocop', '~> 1.79.1'
  s.add_development_dependency 'rubocop-performance', '~> 1.24.0'
  s.add_development_dependency 'rubocop-rspec', '~> 3.6.0'
  s.add_development_dependency 'site_prism', '> 4', '< 6'
  s.add_development_dependency 'yard', '~> 0.9'
end
