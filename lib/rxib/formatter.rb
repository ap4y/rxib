module RXib
  class Formatter
    attr_reader :output

    def initialize(document, pretty: true, indentation: 4)
      @document = document
      @output = ''
      @indentation = indentation
    end

    def format
      attrs = [:version, :encoding, :standalone].map do |getter|
        value = @document.xml_declaration.public_send(getter)
        attribute(getter, value)
      end
      line("<?xml #{attrs.compact.join(' ')}?>")

      @document.children.each do |element|
        dump_element(element)
      end
    end

    private

    def dump_element(element, level = 0)
      attrs = element.attributes.each_with_object('') do |attr, acc|
        attr_str = attribute(attr.name, attr.value)
        acc << " #{attr_str}" if attr_str
      end

      if element.self_closing?
        line("<#{element.name}#{attrs}/>", level)
      else
        line("<#{element.name}#{attrs}>", level)
        element.children.each { |child| dump_element(child, level + 1) }
        line("</#{element.name}>", level)
      end
    end

    def line(string, level = 0)
      @output << (' ' * level * @indentation) + string + "\n"
    end

    def attribute(name, value)
      return unless value
      %Q{#{name}="#{value}"}
    end
  end
end
