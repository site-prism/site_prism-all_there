# frozen_string_literal: true

RSpec.shared_context 'with mock pages' do
  let(:passing_page) { instance_double('SitePrism::Page', 'Passing') }
  let(:failing_page) { instance_double('SitePrism::Page', 'Failing') }
end
