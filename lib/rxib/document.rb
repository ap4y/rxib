module RXib
  class Document < Oga::XML::Document
    def xml_declaration
      Oga::XML::XmlDeclaration
        .new(version: '1.0', encoding: 'UTF-8', standalone: 'no')
    end
  end
end
