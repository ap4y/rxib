module RXib
  module Font
    class Custom
      attr_reader :family, :name, :point_size

      def initialize(components)
        case components.count
        when 2
          @family = font_family(components[0])
          @name = components[0]
          @point_size = components[1].to_f.to_s
        when 3
          @family = font_family(components[0])
          @name = components[0] + '-' + components[1]
          @point_size = components[2].to_f.to_s
        end
      end

      private

      def font_family(capitalized_value)
        capitalized_value.scan(/[A-Z][a-z]+/).join(' ')
      end
    end
  end
end
