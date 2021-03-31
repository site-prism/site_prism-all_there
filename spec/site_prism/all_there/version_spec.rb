# frozen_string_literal: true

describe 'SitePrism::AllThere' do
  describe 'VERSION' do
    subject { SitePrism::AllThere::VERSION }

    it { is_expected.to be_truthy }
  end
end
