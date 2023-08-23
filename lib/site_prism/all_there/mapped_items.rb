# frozen_string_literal: true

module SitePrism
  module AllThere
    #
    # @api private
    #
    # The Expected Items on a SitePrism Page or Section structured in an enumerable way
    #
    class MappedItems
      attr_reader :hash

      # @return [Hash]
      # Return a list of all mapped items on a SitePrism class instance (Page or Section)
      def initialize(instance)
        @hash = instance.class.mapped_items
      end

      # @return [Array<Symbol>]
      # All expected mapped items on the SitePrism instance as a Symbol Array
      def array
        hash.values.flatten.uniq
      end
    end
  end
end
