module RXib
  class SaxHandler
    attr_reader :document

    def initialize
      @document = Document.new
      @stack = []
    end

    def on_element(namespace, name, attrs = {})
      el = RXib.instantiate(name.to_sym)
      parent = (@stack.last && @stack.last.root_element) || @document
      parent.children << el
      @stack << el

      attrs.each { |key, value| el.public_send("#{key}=", value) }
    end

    def on_text(text)
      element = @stack.last
      element.text = text.strip if element.respond_to?('text=')
    end

    def after_element(namespace, name)
      @stack.pop
    end
  end
end
