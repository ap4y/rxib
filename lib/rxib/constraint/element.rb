module RXib
  module Constraint
    class Element < RXib::Element
      def initialize(name, constraint)
        super(name: 'constraint')
        property(:id, default: RXib.generate_id)
        @constraint = constraint
        send(name)
      end

      private

      def width
        property(:first_attribute, default: 'width')
        property(:constant, default: @constraint.constant)
      end

      def height
        property(:first_attribute, default: 'height')
        property(:constant, default: @constraint.constant)
      end

      def horizontal
        property(:constant, default: @constraint.constant)

        property(:first_item, default: @constraint.first_item)
        property(:second_item, default: @constraint.second_item)

        attributes = @constraint.horizontal_attributes
        property(:first_attribute, default: attributes[0])
        property(:second_attribute, default: attributes[1])
      end

      def vertical
        property(:constant, default: @constraint.constant)

        property(:first_item, default: @constraint.first_item)
        property(:second_item, default: @constraint.second_item)

        attributes = @constraint.vertical_attributes
        property(:first_attribute, default: attributes[0])
        property(:second_attribute, default: attributes[1])
      end
    end
  end
end
