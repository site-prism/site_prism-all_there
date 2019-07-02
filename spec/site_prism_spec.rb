# frozen_string_literal: true

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
        config.recursion_setting = :foo
        config.recursion_setting
      end
    end
  end

  describe '.recursion_setting' do
    subject { SitePrism.recursion_setting }

    it { is_expected.to eq(:none) }
  end

  describe '.recursion_setting=' do
    it 'is alters the recursion_setting' do
      SitePrism.recursion_setting = :one

      expect(SitePrism.recursion_setting).to eq(:one)
    end
  end
end
