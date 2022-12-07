# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'site_prism/all_there'

require 'site_prism'
require 'capybara'
require 'capybara/dsl'

require_relative 'support/shared_context/page_types'

RSpec.configure do |config|
  config.include_context('with mock pages')
end
