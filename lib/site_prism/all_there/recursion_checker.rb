# frozen_string_literal: true

module SitePrism
  module AllThere
    #
    # @api private
    #
    # This will recurse through all of the objects found on an individual Page/Section level
    # It will perform the `#all_there?` check on each `@instance` item that it is initialized with
    #
    class RecursionChecker
      attr_reader :instance
      private :instance

      def initialize(instance)
        @instance = instance
      end

      # @return [Boolean || Nil]
      # This is only meant to be invoked from the main site_prism gem where it will use whatever inputs it is given
      def all_there?(recursion: nil, options: {})
        setting = recursion || SitePrism.recursion_setting

        case setting
        when nil, :none
          current_class_all_there?(**options)
        when :one
          current_class_all_there?(**options) && section_classes_all_there?(options) && sections_classes_all_there?(options)
        else
          SitePrism.logger.debug("Invalid input value '#{recursion}'. Valid values are 'nil', ':none' or ':one'.")
          SitePrism.logger.error('Invalid recursion setting, Will not run #all_there?.')
        end
      end

      private

      def current_class_all_there?(**opts)
        expected_items.array.flatten.all? { |name| there?(name, **opts) }.tap do |result|
          SitePrism.logger.debug("Result of current_class_all_there? for #{instance.class}: #{result}")
        end
      end

      def section_classes_all_there?(opts)
        section_classes_to_check.all? { |section| section.all_there?(options: opts) }.tap do |result|
          SitePrism.logger.debug("Result of #section_classes_all_there? for #{instance.class}: #{result}")
        end
      rescue Capybara::ElementNotFound
        SitePrism.logger.error("Error whilst attempting to locate all section classes from within #{instance.class}")
        false
      end

      def sections_classes_all_there?(opts)
        sections_classes_to_check.flatten.all? { |section| section.all_there?(options: opts) }.tap do |result|
          SitePrism.logger.debug("Result of #sections_classes_all_there? for #{instance.class}: #{result}")
        end
      rescue Capybara::ElementNotFound
        SitePrism.logger.error("Error whilst attempting to locate all sections (plural), classes from within #{instance.class}")
        false
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

      def there?(name, **opts)
        instance.send(:"has_#{name}?", **opts)
      end
    end
  end
end
