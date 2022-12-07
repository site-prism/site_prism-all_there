# frozen_string_literal: true

RSpec.shared_context 'with mock pages' do
  let(:passing_page) { instance_double('SitePrism::Page', 'Passing', all_there?: true) }
  let(:failing_page) { instance_double('SitePrism::Page', 'Failing', all_there?: false) }
end
