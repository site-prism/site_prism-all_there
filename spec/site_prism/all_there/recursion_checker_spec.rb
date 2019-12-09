# frozen_string_literal: true

describe SitePrism::AllThere::RecursionChecker do
  let(:passing_page) { instance_double('SitePrism::Page', 'Passing', all_there?: true) }
  let(:failing_page) { instance_double('SitePrism::Page', 'Failing', all_there?: false) }
  let(:passing_section) { instance_double('SitePrism::Section', 'Passing', all_there?: true) }
  let(:failing_section) { instance_double('SitePrism::Section', 'Failing', all_there?: false) }
  let(:passing_sections) { [passing_section, passing_section] }
  let(:failing_sections) { [passing_section, failing_section] }

  describe '#all_there?' do
    context 'with recursion not set' do
      it 'returns `true` for pages that are `all_there?`' do
        expect(passing_page.all_there?).to be true
      end

      it 'returns `false` for pages that are not `all_there?`' do
        expect(failing_page.all_there?).to be false
      end

      it 'does not perform checks on descendant section/s' do
        expect(passing_page).not_to receive(:all_there?) do
          section_there? && sections_there?
        end
      end
    end

    context 'with recursion set to :none' do
      it 'returns `true` for pages that are `all_there?`' do
        expect(passing_page.all_there?(recursion: :none)).to be true
      end

      it 'returns `false` for pages that are not `all_there?`' do
        expect(failing_page.all_there?(recursion: :none)).to be false
      end

      it 'does not perform checks on descendant section/s' do
        expect(passing_page).not_to receive(:all_there?).with(recursion: :one) do
          section_there? && sections_there?
        end
      end
    end

    context 'with recursion set to :one' do
      let(:page_there?) { passing_page.all_there? }
      let(:section_there?) { passing_page.section_classes_to_check.all?(&:all_there?) }
      let(:sections_there?) { passing_page.sections_classes_to_check.flatten.all?(&:all_there?) }

      before do
        # Set the `all_there?` check to be the legit one that recurses
        allow(passing_page).to receive(:all_there?).with(recursion: :one) do
          page_there? && section_there? && sections_there?
        end
      end

      it 'returns `true` for pages that have every item and descendant item present' do
        mock_page_as :passing

        expect(passing_page.all_there?(recursion: :one)).to be true
      end

      it 'performs checks on both the current page, as well as all descendant section/s' do
        mock_page_as :passing

        expect(passing_page).to receive(:all_there?).with(recursion: :one) do
          page_there? && section_there? && sections_there?
        end

        passing_page.all_there?(recursion: :one)
      end

      it 'returns `false` for pages that do not have every item and descendant item present' do
        mock_page_as :failing

        expect(passing_page.all_there?(recursion: :one)).to be false
      end
    end
  end

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
