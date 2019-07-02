# frozen_string_literal: true

describe 'SitePrism::AllThere::RecursionChecker' do
  let(:passing_page) { double('A Page with all Items Present', all_there?: true) }
  let(:failing_page) { double('A Page with some Items Missing', all_there?: false) }
  let(:passing_section) { double('A Section with all Items Present', all_there?: true) }
  let(:failing_section) { double('A Section with some Items Missing', all_there?: false) }
  let(:passing_sections) { [passing_section, passing_section] }
  let(:failing_sections) { [passing_section, failing_section] }

  describe '#all_there?' do
    context 'with recursion not set' do
      it 'should return true for pages that are all_there?' do
        expect(passing_page.all_there?).to be true
      end

      it 'should return false for pages that are not all_there?' do
        expect(failing_page.all_there?).to be false
      end
    end

    context 'with recursion set to :none' do
      it 'should return true for pages that are all_there?' do
        expect(passing_page.all_there?(recursion: :none)).to be true
      end

      it 'should return false for pages that are not all_there?' do
        expect(failing_page.all_there?(recursion: :none)).to be false
      end
    end

    context 'with recursion set to :one' do
      it 'should return true for pages that have every item and descendent item there' do
        # This allows the Array to be enumerated using #all_there?
        allow_any_instance_of(Array).to receive(:all_there?) do |array|
          array.all?(&:all_there?)
        end

        # This mocks the passing page having a set of section/sections items
        # attached to it
        allow(passing_page)
          .to receive_messages(
            section_classes_to_check: passing_sections,
            sections_classes_to_check: [
              [passing_section, passing_section],
              [passing_section, passing_section, passing_section],
              [passing_section],
            ]
          )

        # This performs the recursion logic across the current scope, the section
        # items and the sections items
        expect(passing_page).to receive(:all_there?).with(recursion: :one) do
          passing_page.all_there? &&
            passing_page.section_classes_to_check.all_there? &&
            passing_page.sections_classes_to_check.all_there?
        end

        expect(passing_page.all_there?(recursion: :one)).to be true
      end

      it 'should return false for pages that do not have every item and descendent item there' do
        # This allows the Array to be enumerated using #all_there?
        allow_any_instance_of(Array).to receive(:all_there?) do |array|
          array.all?(&:all_there?)
        end

        # This mocks the passing page having a set of section/sections items
        # attached to it
        allow(passing_page)
          .to receive_messages(
            section_classes_to_check: passing_sections,
            sections_classes_to_check: [
              [passing_section, passing_section],
              [passing_section, failing_section, passing_section],
              [passing_section],
            ]
          )

        # This performs the recursion logic across the current scope, the section
        # items and the sections items
        expect(passing_page).to receive(:all_there?).with(recursion: :one) do
          passing_page.all_there? &&
            passing_page.section_classes_to_check.all_there? &&
            passing_page.sections_classes_to_check.all_there?
        end

        expect(passing_page.all_there?(recursion: :one)).to be false
      end
    end
  end
end
