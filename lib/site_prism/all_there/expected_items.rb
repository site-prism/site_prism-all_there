# frozen_string_literal: true

module SitePrism
  module AllThere
    #
    # @api private
    #
    # The Expected Item Map on a SitePrism Page or Section
    class ExpectedItems
      attr_reader :instance
      private :instance

      def initialize(instance)
        @instance = instance
      end

      def array
        [
          mapped_checklist_of(:element),
          mapped_checklist_of(:elements),
          mapped_checklist_of(:section),
          mapped_checklist_of(:sections),
          mapped_checklist_of(:iframe),
        ]
      end

      def element
        mapped_checklist_of(:element)
      end

      def elements
        mapped_checklist_of(:elements)
      end

      def section
        mapped_checklist_of(:section)
      end

      def sections
        mapped_checklist_of(:sections)
      end

      def iframe
        mapped_checklist_of(:iframe)
      end

      private

      def mapped_checklist_of(type)
        mapped_items.hash[type].select { |name| mapped_checklist.include?(name) }
      end

      # If the page or section has expected_items set, return expected_items that are mapped
      # otherwise just return the list of all mapped_items
      def mapped_checklist
        if checklist
          SitePrism.logger.debug('Expected Items has been set.')
          mapped_items.array.select { |name| checklist.include?(name) }
        else
          mapped_items.array
        end
      end

      # List of expected_items as defined during build phase
      def checklist
        instance.class.expected_items
      end

      def mapped_items
        @mapped_items ||= MappedItems.new(instance)
      end
    end
  end
end
