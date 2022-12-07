# frozen_string_literal: true

# require 'site_prism'
require 'capybara'
require 'capybara/dsl'

describe SitePrism::AllThere::RecursionChecker do
  let(:positive) { described_class.new(passing_page) }
  let(:negative) { described_class.new(failing_page) }

  before do
    allow(positive).to receive(:current_class_all_there?).and_return(true)
    allow(positive).to receive(:section_classes_all_there?).and_return(true)
    allow(positive).to receive(:sections_classes_all_there?).and_return(true)
    allow(negative).to receive(:current_class_all_there?).and_return(false)
    allow(negative).to receive(:section_classes_all_there?).and_return(false)
    allow(negative).to receive(:sections_classes_all_there?).and_return(false)
  end

  describe '#all_there?' do
    context 'with recursion not set - it will recurse by default' do
      it 'returns `true` for pages that have every item and descendant item present' do
        expect(positive.all_there?).to be true
      end

      it 'returns `false` for pages that do not have every item and descendant item present' do
        expect(negative.all_there?).to be false
      end

      it 'performs checks on the page itself' do
        expect(positive).to receive(:current_class_all_there?)

        positive.all_there?
      end

      it 'performs checks on descendant `section` items' do
        expect(positive).to receive(:section_classes_all_there?)

        positive.all_there?
      end

      it 'performs checks on descendant `sections` items' do
        expect(positive).to receive(:sections_classes_all_there?)

        positive.all_there?
      end
    end

    context 'with recursion set to :none' do
      it 'returns `true` for pages that are `all_there?`' do
        expect(positive.all_there?(recursion: :none)).to be true
      end

      it 'returns `false` for pages that are not `all_there?`' do
        expect(negative.all_there?(recursion: :none)).to be false
      end

      it 'does not perform checks on descendant section items' do
        expect(positive).not_to receive(:section_classes_all_there?)

        positive.all_there?(recursion: :none)
      end

      it 'does not perform checks on descendant sections items' do
        expect(positive).not_to receive(:sections_classes_all_there?)

        positive.all_there?(recursion: :none)
      end

      it 'will check the value of SitePrism.recursion_setting' do
        expect(SitePrism).to receive(:recursion_setting)

        positive.all_there?(recursion: :none)
      end
    end

    context 'with recursion set to :one' do
      let(:page_there?) { passing_page.all_there? }
      let(:sections_there?) { passing_page.sections_classes_to_check.flatten.all?(&:all_there?) }
      let(:section_there?) { passing_page.section_classes_to_check.all?(&:all_there?) }

      before do
        # Set the `all_there?` check to be the legit one that recurses
        allow(passing_page).to receive(:all_there?).with(recursion: :one) do
          page_there? && section_there? && sections_there?
        end
      end

      it 'returns `true` for pages that have every item and descendant item present' do
        expect(positive.all_there?(recursion: :one)).to be true
      end

      it 'returns `false` for pages that do not have every item and descendant item present' do
        expect(negative.all_there?(recursion: :one)).to be false
      end

      it 'performs checks on the page itself' do
        expect(positive).to receive(:current_class_all_there?)

        positive.all_there?(recursion: :one)
      end

      it 'performs checks on descendant section items' do
        expect(positive).to receive(:section_classes_all_there?)

        positive.all_there?(recursion: :one)
      end

      it 'performs checks on descendant sections items' do
        expect(positive).to receive(:sections_classes_all_there?)

        positive.all_there?(recursion: :one)
      end
    end

    it 'will check the value of SitePrism.recursion_setting if recursion is not :one' do
      expect(SitePrism).to receive(:recursion_setting)

      positive.all_there?(recursion: :not_one)
    end
  end
end
