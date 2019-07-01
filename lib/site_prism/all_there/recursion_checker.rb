# frozen_string_literal: true

module SitePrism
  module AllThere
    class RecursionChecker
      attr_reader :instance
      private :instance

      def initialize(instance)
        @instance = instance
      end

      def all_there?
        current_class_all_there? &&
          section_classes_all_there? &&
          sections_classes_all_there?
      end

      private

      # This will check all elements that are in the current scope
      # This is equivalent to checking a recursion value of +:none+
      def current_class_all_there?
        expected_item_map.flatten.all? { |name| there?(name) }
      end

      # This will check all elements that are in any of the individual
      # +section+ items defined in the current scope
      def section_classes_all_there?
        section_classes_to_check.all?(&:all_there?)
      end

      # This will check all elements that are in any instance of any of the
      # +sections+ items defined in the current scope
      def sections_classes_all_there?
        sections_classes_to_check.all?(&:all_there?)
      end

      def section_classes_to_check
        expected_item_map[2].map { |name| instance.send(name) }
      end

      def sections_classes_to_check
        expected_item_map[3].map { |name| instance.send(name) }.flatten
      end

      def expected_item_map
        [
          expected(mapped_items, :element),
          expected(mapped_items, :elements),
          expected(mapped_items, :section),
          expected(mapped_items, :sections),
          expected(mapped_items, :iframe),
        ]
      end

      def expected(map, type)
        map[type].select { |name| elements_to_check.include?(name) }
      end

      # If the page or section has expected_items set, return expected_items that are mapped
      # otherwise just return the list of all mapped_items
      def elements_to_check
        if _expected_items
          SitePrism.logger.debug('Expected Items has been set.')
          _mapped_items.select { |name| _expected_items.include?(name) }
        else
          _mapped_items
        end
      end

      def _mapped_items
        mapped_items.values.flatten.uniq
      end

      def _expected_items
        instance.class.expected_items
      end

      def there?(name)
        instance.send("has_#{name}?")
      end

      def mapped_items
        @mapped_items ||= instance.class.mapped_items(legacy: false)
      end
    end
  end
end
