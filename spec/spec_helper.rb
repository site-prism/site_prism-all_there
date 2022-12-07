# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'site_prism/all_there'
require_relative 'support/shared_context/page_types'
require_relative 'support/shared_context/section_types'

RSpec.configure do |config|
  config.include_context('with mock pages')
  config.include_context('with mock sections')
end
