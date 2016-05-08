module RXib
  class SaxHandler
    attr_reader :document

    def initialize
      @document = Document.new
      @stack = []
    end

    def on_element(namespace, name, attrs = {})
      el = RXib.instantiate(name.to_sym)
      attrs.each { |key, value| el.public_send("#{key}=", value) }

      parent = (@stack.last && @stack.last.root_element) || @document
      parent.children << el
      @stack << el
    end

    def after_element(namespace, name)
      @stack.pop
    end
  end
end
