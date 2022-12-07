# frozen_string_literal: true

RSpec.shared_context 'Section Types' do
  let(:passing_sections) { [passing_section, passing_section] }
  let(:failing_sections) { [passing_section, failing_section] }

  let(:passing_section) { instance_double('SitePrism::Section', 'Passing', all_there?: true) }
  let(:failing_section) { instance_double('SitePrism::Section', 'Failing', all_there?: false) }
end
