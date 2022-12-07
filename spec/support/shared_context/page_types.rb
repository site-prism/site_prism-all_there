# frozen_string_literal: true

RSpec.shared_context 'with mock pages' do
  let(:passing_page) { instance_double('SitePrism::Page', 'Passing') }
  let(:failing_page) { instance_double('SitePrism::Page', 'Failing') }

  # This mocks the `passing_page` as having a set of section/sections items attached.
  # Dependent on `type` parameter depends on whether this will pass or fail the +#all_there?+
  # check that will be called on passing_page
  def mock_page_as(type)
    allow(passing_page)
      .to receive_messages(
        section_classes_to_check: passing_sections,
        sections_classes_to_check: [
          passing_sections,
          send("#{type}_sections"),
        ]
      )
  end
end
