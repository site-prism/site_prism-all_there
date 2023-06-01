# frozen_string_literal: true

require './lib/site_prism/all_there/version'

Gem::Specification.new do |s|
  s.name        = 'site_prism-all_there'
  s.version     = SitePrism::AllThere::VERSION
  s.required_ruby_version = '>= 2.6'
  s.platform    = Gem::Platform::RUBY
  s.license     = 'BSD-3-Clause'
  s.authors     = ['Luke Hill']
  s.email       = %w[lukehill_uk@hotmail.com]
  s.homepage    = 'https://github.com/site-prism/site_prism-all_there'
  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/site-prism/site_prism-all_there/issues',
    'changelog_uri' => 'https://github.com/site-prism/site_prism-all_there/blob/main/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/site-prism/site_prism-all_there',
  }
  s.summary     = 'An extension to allow you to recurse through your SitePrism Pages/Sections'
  s.description = 'SitePrism AllThere gives you a simple DSL in order to recursively query,
page/section/element structures on your page - exclusively for use with the SitePrism gem.'
  s.files        = Dir.glob('lib/**/*') + %w[LICENSE.md README.md]
  s.require_path = 'lib'

  s.add_development_dependency 'rspec', ['~> 3.12']
  s.add_development_dependency 'rubocop', ['~> 1.50.2']
  s.add_development_dependency 'rubocop-performance', ['~> 1.17.1']
  s.add_development_dependency 'rubocop-rspec', ['~> 2.20.0']
  s.add_development_dependency 'site_prism', ['> 3.7', '< 5']
  s.add_development_dependency 'yard', ['~> 0.9']
end
