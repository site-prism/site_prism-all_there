# frozen_string_literal: true

module SitePrism
  module AllThere
    #
    # @api private
    #
    # The Expected Items to be present on a SitePrism Page or Section
    #
    class ExpectedItems
      attr_reader :instance
      private :instance

      def initialize(instance)
        @instance = instance
      end

      # @return [Array<Array<Symbol>>]
      # All defined/expected mapped items
      def array
        [
          mapped_checklist_of(:element),
          mapped_checklist_of(:elements),
          section,
          sections,
          mapped_checklist_of(:iframe)
        ]
      end

      # @return [Array<Symbol>]
      # All defined/expected items that were mapped as +section+
      def section
        mapped_checklist_of(:section)
      end

      # @return [Array<Symbol>]
      # All defined/expected items that were mapped as +sections+
      def sections
        mapped_checklist_of(:sections)
      end

      private

      def mapped_checklist_of(type)
        mapped_items.hash[type] & mapped_checklist
      end

      def mapped_checklist
        if instance.class.expected_items
          SitePrism.logger.debug('Expected Items has been set.')
          mapped_items.array & instance.class.expected_items
        else
          mapped_items.array
        end
      end

      def mapped_items
        @mapped_items ||= MappedItems.new(instance)
      end
    end
  end
end
