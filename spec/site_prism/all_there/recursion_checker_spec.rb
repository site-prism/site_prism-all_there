# frozen_string_literal: true

describe SitePrism::AllThere::RecursionChecker do
  let(:completely_present) { described_class.new(double) }
  let(:completely_missing) { described_class.new(double) }
  let(:partially_present) { described_class.new(double) }

  before do
    allow(completely_present).to receive(:current_class_all_there?).and_return(true)
    allow(completely_present).to receive(:section_classes_all_there?).and_return(true)
    allow(completely_present).to receive(:sections_classes_all_there?).and_return(true)
    allow(completely_missing).to receive(:current_class_all_there?).and_return(false)
    allow(completely_missing).to receive(:section_classes_all_there?).and_return(false)
    allow(completely_missing).to receive(:sections_classes_all_there?).and_return(false)
    allow(partially_present).to receive(:current_class_all_there?).and_return(true)
    allow(partially_present).to receive(:section_classes_all_there?).and_return(false)
    allow(partially_present).to receive(:sections_classes_all_there?).and_return(false)
  end

  describe '#all_there?' do
    context 'with recursion not set - it will recurse by default' do
      it 'returns `true` for pages that have every item and descendant item present' do
        expect(completely_present.all_there?).to be true
      end

      it 'returns `false` for pages that do not have every item and descendant item present' do
        expect(completely_missing.all_there?).to be false
      end

      it 'returns `false` for pages that have regular items present BUT NOT descendant items' do
        expect(partially_present.all_there?).to be false
      end

      it 'performs checks on the page itself' do
        expect(completely_present).to receive(:current_class_all_there?)

        completely_present.all_there?
      end

      it 'performs checks on descendant `section` items' do
        expect(completely_present).to receive(:section_classes_all_there?)

        completely_present.all_there?
      end

      it 'performs checks on descendant `sections` items' do
        expect(completely_present).to receive(:sections_classes_all_there?)

        completely_present.all_there?
      end
    end

    context 'with recursion set to :none' do
      it 'returns `true` for pages that have every item present' do
        expect(completely_present.all_there?(recursion: :none)).to be true
      end

      it 'returns `false` for pages that do not have every item present' do
        expect(completely_missing.all_there?(recursion: :none)).to be false
      end

      it 'returns `true` for pages that have regular items present BUT NOT descendant items' do
        expect(partially_present.all_there?(recursion: :none)).to be true
      end

      it 'does not perform checks on descendant section items' do
        expect(completely_present).not_to receive(:section_classes_all_there?)

        completely_present.all_there?(recursion: :none)
      end

      it 'does not perform checks on descendant sections items' do
        expect(completely_present).not_to receive(:sections_classes_all_there?)

        completely_present.all_there?(recursion: :none)
      end

      it 'will check the value of SitePrism.recursion_setting' do
        expect(SitePrism).to receive(:recursion_setting)

        completely_present.all_there?(recursion: :none)
      end
    end

    context 'with recursion set to :one' do
      it 'returns `true` for pages that have every item and descendant item present' do
        expect(completely_present.all_there?(recursion: :one)).to be true
      end

      it 'returns `false` for pages that do not have every item and descendant item present' do
        expect(completely_missing.all_there?(recursion: :one)).to be false
      end

      it 'returns `false` for pages that have regular items present BUT NOT descendant items' do
        expect(partially_present.all_there?(recursion: :one)).to be false
      end

      it 'performs checks on the page itself' do
        expect(completely_present).to receive(:current_class_all_there?)

        completely_present.all_there?(recursion: :one)
      end

      it 'performs checks on descendant section items' do
        expect(completely_present).to receive(:section_classes_all_there?)

        completely_present.all_there?(recursion: :one)
      end

      it 'performs checks on descendant sections items' do
        expect(completely_present).to receive(:sections_classes_all_there?)

        completely_present.all_there?(recursion: :one)
      end
    end

    it 'will check the value of SitePrism.recursion_setting if recursion is not :one' do
      expect(SitePrism).to receive(:recursion_setting)

      completely_present.all_there?(recursion: :not_one)
    end

    it 'will not perform any methods if recursion is not valid' do
      expect(SitePrism).to receive(:logger).twice.and_call_original

      completely_present.all_there?(recursion: :not_one)
    end
  end
end
