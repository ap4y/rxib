module RXib
  module Font
    class System
      attr_reader :type, :weight, :point_size

      def initialize(components)
        case components.count
        when 2
          @type = 'system'
          @point_size = components[1].to_f.to_s
        when 3
          if components[1] == 'Italic'
            @type = 'italicSystem'
          else
            @type = 'system'
            @weight = font_weight(components[1])
          end
          @point_size = components[2].to_f.to_s
        end
      end

      private

      def font_weight(capitalized_value)
        terms = capitalized_value.scan(/[A-Z][a-z]+/)
        terms[0].downcase!
        terms[1..-1].each(&:capitalize!)
        terms.join
      end
    end
  end
end
