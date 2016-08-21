module RXib
  class Attribute
    attr_reader :name
    attr_accessor :value

    def initialize(name, value)
      @name = name
      @value = value
    end

    def synthesize
      value = if @value.is_a?(Proc)
                @value.call()
              else
                @value
              end
      Oga::XML::Attribute.new(name: @name, value: value)
    end
  end
end
