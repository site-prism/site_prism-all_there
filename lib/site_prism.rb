# frozen_string_literal: true

# Configure the behaviour of the site_prism-all_there gem
module SitePrism
  class << self
    attr_writer :recursion_setting

    def configure
      yield self
    end

    # Pass in a configuration setting to use on a global scale
    # Note this can be overridden at runtime for each individual call
    def recursion_setting
      @recursion_setting ||= :none
    end
  end
end
