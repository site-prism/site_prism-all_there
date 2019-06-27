# frozen_string_literal: true

module SitePrism
  autoload :RecursionChecker, 'site_prism/all_there/recursion_checker'

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
