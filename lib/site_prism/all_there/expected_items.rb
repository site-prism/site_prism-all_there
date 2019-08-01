# frozen_string_literal: true

module SitePrism
  module AllThere
    # Returns the Expected Item Map on a specific SitePrism object
    #
    # api private
    #
    class ExpectedItems
      attr_reader :instance, :mapped_items
      private :instance, :mapped_items

      def initialize(instance, mapped_items)
        @instance = instance
        @mapped_items = mapped_items
      end

      def expected_item_map
        [
          expected(:element),
          expected(:elements),
          expected(:section),
          expected(:sections),
          expected(:iframe),
        ]
      end

      private

      def expected(type)
        mapped_items.hash[type].select { |name| elements_to_check.include?(name) }
      end

      # If the page or section has expected_items set, return expected_items that are mapped
      # otherwise just return the list of all mapped_items
      def elements_to_check
        if _expected_items
          SitePrism.logger.debug('Expected Items has been set.')
          mapped_items.array.select { |name| _expected_items.include?(name) }
        else
          mapped_items.array
        end
      end

      def _expected_items
        instance.class.expected_items
      end
    end
  end
end
