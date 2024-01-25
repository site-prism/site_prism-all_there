# frozen_string_literal: true

describe SitePrism::AllThere::RecursionChecker do
  let(:checker) { described_class.new(double) }

  before do
    allow(checker)
      .to receive_messages(
        current_class_all_there?: true,
        section_classes_all_there?: true,
        sections_classes_all_there?: true
      )
  end

  after { SitePrism.recursion_setting = nil }

  describe '#all_there?' do
    context 'with pages that have all `expected_items` and descendent items present' do
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

    context 'with pages that are missing some `expected_items` and also missing some descendent items' do
      before do
        allow(checker)
          .to receive_messages(
            current_class_all_there?: false,
            section_classes_all_there?: false,
            sections_classes_all_there?: false
          )
      end

      it 'returns `false` when checking all items without recursion' do
        expect(checker.all_there?(recursion: :none)).to be false
      end

      it 'does not perform checks on descendant section items without recursion' do
        expect(checker).not_to receive(:section_classes_all_there?)

        checker.all_there?(recursion: :none)
      end

      it 'does not perform checks on descendant sections items without recursion' do
        expect(checker).not_to receive(:sections_classes_all_there?)

        checker.all_there?(recursion: :none)
      end

      it 'returns `false` when checking all items with recursion' do
        expect(checker.all_there?(recursion: :one)).to be false
      end

      it 'performs checks on the page itself with recursion' do
        expect(checker).to receive(:current_class_all_there?)

        checker.all_there?(recursion: :one)
      end
    end

    context 'with pages that have all `expected_items` but are missing some descendent items' do
      before do
        allow(checker)
          .to receive_messages(
            current_class_all_there?: true,
            section_classes_all_there?: false,
            sections_classes_all_there?: false
          )
      end

      it 'returns `true` when checking all items without recursion' do
        expect(checker.all_there?(recursion: :none)).to be true
      end

      it 'returns `false` when checking all items with recursion' do
        expect(checker.all_there?(recursion: :one)).to be false
      end
    end

    it 'performs no checks if the recursion parameter is not valid' do
      expect(SitePrism).to receive(:logger).twice.and_call_original

      checker.all_there?(recursion: :not_one)
    end

    it 'checks the value of `SitePrism.recursion_setting` when no recursion parameter is passed in' do
      SitePrism.recursion_setting = :one

      expect(SitePrism).to receive(:recursion_setting).once

      checker.all_there?
    end
  end
end
