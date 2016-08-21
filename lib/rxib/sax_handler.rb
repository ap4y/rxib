module RXib
  class SaxHandler
    attr_reader :document

    def initialize
      @document = Oga::XML::Document.new
      @document.xml_declaration =
        Oga::XML::XmlDeclaration
          .new(version: '1.0', encoding: 'UTF-8', standalone: 'no')
      @stack = []
    end

    def on_element(namespace, name, attrs = {})
      klass = Object.const_get('RXib::Elements::' + name.capitalize)
      el = klass.new
      el.synthesize

      parent = (@stack.last && @stack.last.root) || @document
      parent.children << el
      @stack << el

      attrs.each { |key, value| el.set(key, value) }
    end

    def on_text(text)
      element = @stack.last
      txt = text.strip
      element.set('text', txt) if element && txt.length > 0
    end

    def after_element(namespace, name)
      @stack.pop
    end
  end
end
