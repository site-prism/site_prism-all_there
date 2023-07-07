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

    context 'with pages that have all element, elements, section and sections items present' do
      let(:checker) { described_class.new(double) }

      before do
        allow(checker).to receive(:current_class_all_there?).and_return(true)
        allow(checker).to receive(:section_classes_all_there?).and_return(true)
        allow(checker).to receive(:sections_classes_all_there?).and_return(true)
      end

      it 'returns `true` when checking all items without recursion' do
        expect(checker.all_there?(recursion: :none)).to be true
      end

      it 'does not perform checks on descendant section items without recursion' do
        expect(checker).not_to receive(:section_classes_all_there?)

        checker.all_there?(recursion: :none)
      end

      it 'does not perform checks on descendant sections items without recursion' do
        expect(checker).not_to receive(:sections_classes_all_there?)

        checker.all_there?(recursion: :none)
      end

      it 'always checks the value of SitePrism.recursion_setting' do
        expect(SitePrism).to receive(:recursion_setting)

        checker.all_there?(recursion: :none)
      end

      it 'returns `true` when checking all items with recursion' do
        expect(checker.all_there?(recursion: :one)).to be true
      end

      it 'performs checks on the page itself with recursion' do
        expect(checker).to receive(:current_class_all_there?)

        checker.all_there?(recursion: :one)
      end

      it 'performs checks on descendant section items with recursion' do
        expect(checker).to receive(:section_classes_all_there?)

        checker.all_there?(recursion: :one)
      end

      it 'performs checks on descendant sections items with recursion' do
        expect(checker).to receive(:sections_classes_all_there?)

        checker.all_there?(recursion: :one)
      end
    end

    context 'with pages that do not have all element, elements, section and sections items present' do
      let(:checker) { described_class.new(double) }

      before do
        allow(checker).to receive(:current_class_all_there?).and_return(false)
        allow(checker).to receive(:section_classes_all_there?).and_return(false)
        allow(checker).to receive(:sections_classes_all_there?).and_return(false)
      end

      it 'returns `false` when checking all items without recursion' do
        expect(checker.all_there?(recursion: :none)).to be false
      end

      it 'returns `false` when checking all items with recursion' do
        expect(checker.all_there?(recursion: :one)).to be false
      end
    end

    context 'with pages that have some element, elements, section and sections items present' do
      let(:checker) { described_class.new(double) }

      before do
        allow(checker).to receive(:current_class_all_there?).and_return(true)
        allow(checker).to receive(:section_classes_all_there?).and_return(false)
        allow(checker).to receive(:sections_classes_all_there?).and_return(false)
      end

      it 'returns `true` when checking all items without recursion' do
        expect(checker.all_there?(recursion: :none)).to be true
      end

      it 'returns `false` when checking all items with recursion' do
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
