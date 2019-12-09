# frozen_string_literal: true

require 'site_prism/all_there/expected_items'
require 'site_prism/all_there/mapped_items'
require 'site_prism/all_there/recursion_checker'

# Configure the behaviour of the site_prism-all_there gem
module SitePrism
  class << self
    # Configuration setting to use on a global scale
    # Note this global setting can be overridden at runtime for each individual call
    attr_accessor :recursion_setting

    def configure
      yield self
    end
  end
end
