# frozen_string_literal: true

require 'site_prism/all_there/expected_items'
require 'site_prism/all_there/mapped_items'
require 'site_prism/all_there/recursion_checker'

# {SitePrism} namespace - In different folder to avoid namespace clashes!
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

module SitePrism
  # {SitePrism::AllThere} namespace
  module AllThere; end
end
