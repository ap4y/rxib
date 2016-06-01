module RXib
  module Constraint
    class Align
      attr_reader :constant, :constant_position

      def initialize(element, components)
        if components[0] =~ /[A-Za-z|]/
          @constant_position = :right
          @item_id, @constant = components
        else
          @constant_position = :left
          @constant, @item_id = components
        end

        @element_id = element.id
        @item = RXib::Constraint.lookup_item(@item_id, element)
      end

      def first_item
        constant_position == :left ?  @item : @element_id
      end

      def second_item
        constant_position == :left ? @element_id : @item
      end

      def horizontal_attributes
        if constant_position == :left
          [parent_aligned? ? 'trailing' : 'leading', 'trailing']
        else
          ['leading', parent_aligned? ? 'leading' : 'trailing']
        end
      end

      def vertical_attributes
        if constant_position == :left
          [parent_aligned? ? 'bottom' : 'top', 'bottom']
        else
          ['top', parent_aligned? ? 'top' : 'bottom']
        end
      end

      def parent_aligned?
        @item_id == '|'
      end
    end
  end
end
