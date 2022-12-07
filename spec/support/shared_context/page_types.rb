# frozen_string_literal: true

RSpec.shared_context 'with mock pages' do
  let(:mock_page) { instance_double('SitePrism::Page', 'Mock Page') }
end
