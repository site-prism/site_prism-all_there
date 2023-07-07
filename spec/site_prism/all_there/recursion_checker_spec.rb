# frozen_string_literal: true

describe SitePrism::AllThere::RecursionChecker do
  let(:checker) { described_class.new(double) }

  before do
    allow(checker).to receive(:current_class_all_there?).and_return(true)
    allow(checker).to receive(:section_classes_all_there?).and_return(true)
    allow(checker).to receive(:sections_classes_all_there?).and_return(true)
  end

  describe '#all_there?' do
    after { SitePrism.recursion_setting = nil }

    context 'for `completely_present` pages' do
      let(:checker) { described_class.new(double) }

      before do
        allow(checker).to receive(:current_class_all_there?).and_return(true)
        allow(checker).to receive(:section_classes_all_there?).and_return(true)
        allow(checker).to receive(:sections_classes_all_there?).and_return(true)
      end

      # no recursion
      it 'returns `true` for pages that have every item and descendant item present' do
        expect(checker.all_there?(recursion: :none)).to be true
      end

      # no recursion
      it 'does not perform checks on descendant section items' do
        expect(checker).not_to receive(:section_classes_all_there?)

        checker.all_there?(recursion: :none)
      end

      # no recursion
      it 'does not perform checks on descendant sections items' do
        expect(checker).not_to receive(:sections_classes_all_there?)

        checker.all_there?(recursion: :none)
      end

      # no recursion
      it 'will check the value of SitePrism.recursion_setting' do
        expect(SitePrism).to receive(:recursion_setting)

        checker.all_there?(recursion: :none)
      end

      # with recursion
      it 'returns `true` for pages that have every item and descendant item present' do
        expect(checker.all_there?(recursion: :one)).to be true
      end

      # with recursion
      it 'performs checks on the page itself' do
        expect(checker).to receive(:current_class_all_there?)

        checker.all_there?(recursion: :one)
      end

      # with recursion
      it 'performs checks on descendant section items' do
        expect(checker).to receive(:section_classes_all_there?)

        checker.all_there?(recursion: :one)
      end

      # with recursion
      it 'performs checks on descendant sections items' do
        expect(checker).to receive(:sections_classes_all_there?)

        checker.all_there?(recursion: :one)
      end
    end

    context 'for `completely_missing` pages' do
      let(:checker) { described_class.new(double) }

      before do
        allow(checker).to receive(:current_class_all_there?).and_return(false)
        allow(checker).to receive(:section_classes_all_there?).and_return(false)
        allow(checker).to receive(:sections_classes_all_there?).and_return(false)
      end

      # no recursion
      it 'returns `false` for pages that do not have every item present' do
        expect(checker.all_there?(recursion: :none)).to be false
      end

      # with recursion
      it 'returns `false` for pages that do not have every item and descendant item present' do
        expect(checker.all_there?(recursion: :one)).to be false
      end
    end

    context 'for `partially_present` pages' do
      let(:checker) { described_class.new(double) }

      before do
        allow(checker).to receive(:current_class_all_there?).and_return(true)
        allow(checker).to receive(:section_classes_all_there?).and_return(false)
        allow(checker).to receive(:sections_classes_all_there?).and_return(false)
      end

      # no recursion
      it 'returns `true` for pages that have regular items present BUT NOT descendant items' do
        expect(checker.all_there?(recursion: :none)).to be true
      end

      # with recursion
      it 'returns `false` for pages that have regular items present BUT NOT descendant items' do
        expect(checker.all_there?(recursion: :one)).to be false
      end
    end

    it 'will not perform any methods if recursion is not valid' do
      expect(SitePrism).to receive(:logger).twice.and_call_original

      checker.all_there?(recursion: :not_one)
    end

    it 'will take the value of SitePrism.recursion_setting first' do
      SitePrism.recursion_setting = :one

      expect(SitePrism).not_to receive(:logger)

      checker.all_there?(recursion: :not_one)
    end
  end
end
