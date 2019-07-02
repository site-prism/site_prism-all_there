# frozen_string_literal: true

require 'site_prism_at/all_there/recursion_checker'

module SitePrism
  class << self
    attr_writer :recursion_setting

    def configure
      yield self
    end

    def recursion_setting
      @recursion_setting ||= :none
    end
  end
end
