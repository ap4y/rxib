require 'color_conversion'

module RXib
  class ColorHelpers
    def self.parse_to_attributes(el, value)
      color = ColorConversion::Color.new(value)
      r, g, b = color.rgb.values
      el.property(:red, default: format_color(r))
      el.property(:green, default: format_color(g))
      el.property(:blue, default: format_color(b))
      el.property(:alpha, default: color.alpha.to_s)
    end

    def self.update_attributes(el, value)
      color = ColorConversion::Color.new(value)
      r, g, b = color.rgb.values
      el.set(:red, format_color(r))
      el.set(:green, format_color(g))
      el.set(:blue, format_color(b))
      el.set(:alpha, color.alpha.to_s)
    end

    private

    def self.format_color(value)
      (value / 255.0).to_s
    end
  end
end
