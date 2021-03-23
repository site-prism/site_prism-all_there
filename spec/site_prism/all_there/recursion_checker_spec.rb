# frozen_string_literal: true

describe SitePrism::AllThere::RecursionChecker do
  let(:passing_page) { instance_double('SitePrism::Page', 'Passing', all_there?: true) }
  let(:failing_page) { instance_double('SitePrism::Page', 'Failing', all_there?: false) }
  let(:page) { described_class.new(passing_page) }

  before do
    allow(page).to receive(:current_class_all_there?).and_return(true)
    allow(page).to receive(:section_classes_all_there?).and_return(true)
    allow(page).to receive(:sections_classes_all_there?).and_return(true)
  end

  describe '#all_there?' do
    context 'with recursion not set' do
      it 'returns `true` for pages that are `all_there?`' do
        expect(passing_page.all_there?).to be true
      end

      it 'returns `false` for pages that are not `all_there?`' do
        expect(failing_page.all_there?).to be false
      end

      it 'does not perform checks on descendant section items' do
        expect(passing_page).not_to receive(:section_classes_all_there?)

        passing_page.all_there?
      end

      it 'does not perform checks on descendant sections items' do
        expect(passing_page).not_to receive(:sections_classes_all_there?)

        passing_page.all_there?
      end

      it 'will check the value of SitePrism.recursion_setting' do
        expect(SitePrism).to receive(:recursion_setting)

        page.all_there?(recursion: double)
      end
    end

    context 'with recursion set to :none' do
      it 'returns `true` for pages that are `all_there?`' do
        expect(passing_page.all_there?(recursion: :none)).to be true
      end

      it 'returns `false` for pages that are not `all_there?`' do
        expect(failing_page.all_there?(recursion: :none)).to be false
      end

      it 'does not perform checks on descendant section items' do
        expect(passing_page).not_to receive(:section_classes_all_there?)

        passing_page.all_there?
      end

      it 'does not perform checks on descendant sections items' do
        expect(passing_page).not_to receive(:sections_classes_all_there?)

        passing_page.all_there?
      end
    end

    context 'with recursion set to :one' do
      let(:page_there?) { passing_page.all_there? }
      let(:sections_there?) { passing_page.sections_classes_to_check.flatten.all?(&:all_there?) }
      let(:section_there?) { passing_page.section_classes_to_check.all?(&:all_there?) }
      let(:passing_section) { instance_double('SitePrism::Section', 'Passing', all_there?: true) }
      let(:failing_section) { instance_double('SitePrism::Section', 'Failing', all_there?: false) }
      let(:passing_sections) { [passing_section, passing_section] }
      let(:failing_sections) { [passing_section, failing_section] }

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

      it 'returns `false` for pages that do not have every item and descendant item present' do
        mock_page_as :failing

        expect(passing_page.all_there?(recursion: :one)).to be false
      end

      it 'performs checks on the page itself' do
        expect(page).to receive(:current_class_all_there?)

        page.all_there?(recursion: :one)
      end

      it 'performs checks on descendant section items' do
        expect(page).to receive(:section_classes_all_there?)

        page.all_there?(recursion: :one)
      end

      it 'performs checks on descendant sections items' do
        expect(page).to receive(:sections_classes_all_there?)

        page.all_there?(recursion: :one)
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
