require './lib/rxib/font/custom'
require './lib/rxib/font/styled'
require './lib/rxib/font/system'

module RXib
  module Font
    def self.font_for(value)
      components = value.split
      fail "Invalid font value #{value}" if components.count < 1

      klass = case components.count
              when 1 then Styled
              when 2..3
                components[0] == 'System' ? System : Custom
              else
                fail "Invalid font value #{value}"
              end
      klass.new(components)
    end

    def self.assign_attributes(el, font)
      unset_attributes(el)
      props = case
              when font.is_a?(System) then [:type, :weight, :point_size]
              when font.is_a?(Styled) then [:style]
              when font.is_a?(Custom) then [:family, :name, :point_size]
              end

      props.each do |prop|
        attr = RXib.camelize(prop)
        el.set(attr, font.public_send(prop))
      end
    end

    def self.unset_attributes(el)
      [:type, :weight, :pointSize, :style, :family, :name].each do |a|
        el.unset(a)
      end
    end
  end
end
