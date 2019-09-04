# frozen_string_literal: true

describe SitePrism::AllThere do
  describe 'VERSION' do
    subject { described_class::VERSION }

    it { is_expected.to be_truthy }
  end
end
