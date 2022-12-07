# frozen_string_literal: true

describe SitePrism do
  describe '.configure' do
    it 'allows the options to be configured in a block' do
      expect(described_class).to receive(:configure).once

      described_class.configure { |_| :foo }
    end

    it 'yields the configured options' do
      expect(described_class).to receive(:recursion_setting=)

      described_class.configure do |config|
        config.recursion_setting = :foo
      end
    end
  end
end
