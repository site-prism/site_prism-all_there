# frozen_string_literal: true

module SitePrism
  module AllThere
    # Recurse through all of the objects found on an individual Page/Section
    # Perform the all_there? check according to what recursion level is specified
    class RecursionChecker
      attr_reader :instance
      private :instance

      def initialize(instance)
        @instance = instance
      end

      # This is currently hard-coded to perform a recursion of depth +:one+
      # It will be refactored to use either no input, +:none+, or +:one+ as the
      # regular repo uses currently
      def all_there?(recursion: :one)
        if recursion == :one || SitePrism.recursion_setting == :one
          current_class_all_there? &&
            section_classes_all_there? &&
            sections_classes_all_there?
        else
          current_class_all_there?
        end
      end

      private

      # This will check all elements that are in the current scope
      # This is equivalent to checking with a recursion value of +:none+
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
        sections_classes_to_check.flatten.all?(&:all_there?)
      end

      def section_classes_to_check
        expected_item_map[2].map { |name| instance.send(name) }
      end

      def sections_classes_to_check
        expected_item_map[3].map { |name| instance.send(name) }
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

      def expected(type)
        MappedItems.new(instance).hash[type].select { |name| elements_to_check.include?(name) }
      end

      # If the page or section has expected_items set, return expected_items that are mapped
      # otherwise just return the list of all mapped_items
      def elements_to_check
        if _expected_items
          SitePrism.logger.debug('Expected Items has been set.')
          MappedItems.new(instance).array.select do |name|
            _expected_items.include?(name)
          end
        else
          MappedItems.new(instance).array
        end
      end

      def _expected_items
        instance.class.expected_items
      end

      def there?(name)
        instance.send("has_#{name}?")
      end
    end
  end
end
