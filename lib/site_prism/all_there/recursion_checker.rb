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

      # @return [Boolean]
      # This currently defaults to perform a recursion of depth +:one+
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

      # @return [Boolean]
      # Are all SitePrism objects that exist in +self+ present?
      def current_class_all_there?
        expected_items.array.flatten.all? { |name| there?(name) }.tap do |result|
          SitePrism.logger.info("Result of current_class_all_there?: #{result}")
        end
      end

      # @return [Boolean]
      # Are all SitePrism objects that exist in all +self.section+ items present?
      def section_classes_all_there?
        section_classes_to_check.all?(&:all_there?).tap do |result|
          SitePrism.logger.debug("Result of section_classes_all_there?: #{result}")
        end
      end

      # @return [Boolean]
      # Are all SitePrism objects that exist in all +self.sections+ items present?
      def sections_classes_all_there?
        sections_classes_to_check.flatten.all?(&:all_there?).tap do |result|
          SitePrism.logger.debug("Result of section_classes_all_there?: #{result}")
        end
      end

      def section_classes_to_check
        expected_items.section.map { |name| instance.send(name) }
      end

      def sections_classes_to_check
        expected_items.sections.map { |name| instance.send(name) }
      end

      def expected_items
        @expected_items ||= ExpectedItems.new(instance)
      end

      def there?(name)
        instance.send("has_#{name}?")
      end
    end
  end
end
