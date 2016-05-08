require 'color_conversion'

module RXib
  class ColorHelpers
    def self.parse_to_attributes(el, value)
      color = ColorConversion::Color.new(value)
      r, g, b = color.rgb.values
      el.attribute(:red, default: format_color(r))
      el.attribute(:green, default: format_color(g))
      el.attribute(:blue, default: format_color(b))
      el.attribute(:alpha, default: color.alpha.to_s)
    end

    private

    def self.format_color(value)
      (value / 255.0).to_s
    end
  end
end
