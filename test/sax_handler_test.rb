require_relative 'test_helper'

class SaxHandlerTest < Minitest::Test
  def setup
    @handler = RXib::SaxHandler.new
    @doc = @handler.document
  end

  def test_xml_declaration
    decl = @doc.xml_declaration
    assert_equal('1.0', decl.version)
    assert_equal('UTF-8', decl.encoding)
    assert_equal('no', decl.standalone)
  end

  def test_on_element
    @handler.on_element(nil, 'view', 'contentMode' => 'aspectFit')
    @handler.after_element(nil, 'view')

    assert_equal(1, @doc.children.count)

    el = @doc.children.first
    assert_equal('view', el.name)
    assert_equal('aspectFit', el.get('contentMode'))
  end

  def test_on_element_stack
    @handler.on_element(nil, 'view')
    @handler.on_element(nil, 'label')
    @handler.after_element(nil, 'label')
    @handler.after_element(nil, 'view')
    @handler.on_element(nil, 'document')
    @handler.after_element(nil, 'document')

    assert_equal(2, @doc.children.count)
    assert_equal('view', @doc.children.first.name)
    el = @doc.children.first
    assert_equal(1, el.root.children.count)
    assert_equal('label', el.root.children.first.name)

    assert_equal('document', @doc.children.last.name)
  end

  def test_on_text_empty_text
    @handler.on_element(nil, 'label')
    @handler.on_text(' ')
    @handler.after_element(nil, 'label')

    label_el = @doc.children.first
    assert_nil(label_el.get('text'))
  end

  def test_on_text
    @handler.on_element(nil, 'label')
    @handler.on_text('foo')
    @handler.after_element(nil, 'label')

    label_el = @doc.children.first
    assert_equal('foo', label_el.get('text'))
  end

  def test_set_constraint
    @handler.on_element(nil, 'view')
    @handler.on_element(nil, 'label', 'horizontalLayout' => '|-20')
    @handler.after_element(nil, 'label')
    @handler.after_element(nil, 'view')

    el = @doc.children.first
    constraint_el = el.children.last
    assert_equal(1, constraint_el.children.count)
  end
end
