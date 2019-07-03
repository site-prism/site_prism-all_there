# frozen_string_literal: true

module SitePrism
  module AllThere
    # Returns the Mapped Items on a specific SitePrism object
    class MappedItems
      attr_reader :instance
      private :instance

      def initialize(instance)
        @instance = instance
      end

      # All Mapped items on the SitePrism instance as a Symbol Array
      def array
        hash.values.flatten.uniq
      end

      # All Mapped items on the SitePrism instance as a Symbol Hash
      def hash
        instance.class.mapped_items(legacy: false)
      end
    end
  end
end
