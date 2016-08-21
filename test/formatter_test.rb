require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @doc = Oga::XML::Document.new
  end

  def test_xml_decl
    @doc.xml_declaration =
      Oga::XML::XmlDeclaration
        .new(version: '1.0', encoding: 'UTF-8', standalone: 'no')

    formatter = RXib::Formatter.new(@doc)
    formatter.format
    assert_equal('<?xml version="1.0" encoding="UTF-8" standalone="no"?>',
                 formatter.output.rstrip)
  end

  def test_xml_element
    el = Oga::XML::Element.new(name: 'foo')
    el.set('bar', 'baz')
    @doc.children << el

    formatter = RXib::Formatter.new(@doc)
    formatter.format
    assert_equal('<foo bar="baz"/>', formatter.output.rstrip)
  end

  def test_xml_element_nested
    el = Oga::XML::Element.new(name: 'foo')
    child_el = Oga::XML::Element.new(name: 'bar')
    child_el.set('foo', 'baz')
    el.children << child_el
    @doc.children << el

    formatter = RXib::Formatter.new(@doc)
    formatter.format
    assert_equal("<foo>\n    <bar foo=\"baz\"/>\n</foo>",
                 formatter.output.rstrip)
  end
end
