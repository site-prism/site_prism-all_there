# frozen_string_literal: true

# require 'site_prism'

describe SitePrism do
  describe '.configure' do
    it 'can configure the `recursion_setting` in a configure block' do
      expect(SitePrism).to receive(:configure).once

      SitePrism.configure { |_| :foo }
    end

    it 'yields the configured options' do
      expect(SitePrism).to receive(:recursion_setting=)
      expect(SitePrism).to receive(:recursion_setting)

      SitePrism.configure do |config|
        config.recursion_setting = :one
        config.recursion_setting
      end
    end
  end
end
