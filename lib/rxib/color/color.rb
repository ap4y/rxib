require 'color_conversion'

module RXib
  class Color
    attr_reader :red, :green, :blue, :alpha

    def initialize(value)
      color = ColorConversion::Color.new(value)
      @red, @green, @blue = color.rgb.values.map { |c| gamma_value(c) }
      @alpha = color.alpha.to_s
    end

    def self.assign_attributes(el, color)
      %w(red green blue alpha).each do |attr|
        el.set(attr, color.public_send(attr))
      end
    end

    private

    def gamma_value(value)
      (value / 255.0).to_s
    end
  end
end
