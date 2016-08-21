module RXib
  module Constraint
    class Element < Oga::XML::Element
      attr_reader :constraint

      def initialize(constraint)
        super(name: 'constraint')
        set('id', RXib.generate_id)
        @constraint = constraint
        send(constraint.name)
      end

      private

      def width
        set('firstAttribute', 'width')
        set('constant', @constraint.constant)
      end

      def height
        set('firstAttribute', 'height')
        set('constant', @constraint.constant)
      end

      def centerX
        set('firstAttribute', 'centerX')
        set('secondAttribute', 'centerX')
        set('firstItem', @constraint.first_item)
        set('secondItem', @constraint.second_item)
        set('constant', @constraint.constant)
      end

      def centerY
        set('firstAttribute', 'centerY')
        set('secondAttribute', 'centerY')
        set('firstItem', @constraint.first_item)
        set('secondItem', @constraint.second_item)
        set('constant', @constraint.constant)
      end

      def horizontalLayout
        set('constant', @constraint.constant)

        set('firstItem', @constraint.first_item)
        set('secondItem', @constraint.second_item)

        attributes = @constraint.horizontal_attributes
        set('firstAttribute', attributes[0])
        set('secondAttribute', attributes[1])
      end

      def verticalLayout
        set('constant', @constraint.constant)

        set('firstItem', @constraint.first_item)
        set('secondItem', @constraint.second_item)

        attributes = @constraint.vertical_attributes
        set('firstAttribute', attributes[0])
        set('secondAttribute', attributes[1])
      end
    end
  end
end
