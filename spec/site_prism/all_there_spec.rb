# frozen_string_literal: true

describe SitePrism do
  describe '.configure' do
    it 'allows the options to be configured in a block' do
      expect(SitePrism).to receive(:configure).once

      SitePrism.configure { |_| :foo }
    end

    it 'yields the configured options' do
      expect(SitePrism).to receive(:recursion_setting=)
      expect(SitePrism).to receive(:recursion_setting)

      SitePrism.configure do |config|
        config.recursion_setting = :foo
        config.recursion_setting
      end
    end
  end

  describe '.recursion_setting' do
    it 'shows the recursion_setting' do
      expect(SitePrism.recursion_setting).to eq(:none)
    end
  end

  describe '.recursion_setting=' do
    it 'alters the recursion_setting' do
      expect(SitePrism).to receive(:recursion_setting=).with(:one)

      SitePrism.recursion_setting = :one
    end
  end
end
