require_relative 'test_helper'

class BlueprintTest < Minitest::Test
  def setup
    @blueprint = RXib::Blueprint.new
    @el = Oga::XML::Element.new
    class << @el
      include RXib::DSL
    end
  end

  def test_element_name
    @blueprint.name = 'foo'
    assert_equal('foo', @blueprint.name)
  end

  def test_attribute
    @blueprint.attribute('fooBar')
    assert_equal(1, @blueprint.attributes.count)

    attr = @blueprint.attributes.first
    assert_equal('fooBar', attr.name)
  end

  def test_attribute_value
    @blueprint.attribute('fooBar', value: 'bar')

    attr = @blueprint.attributes.first
    assert_equal('bar', attr.value)
  end

  def test_attribute_synthesize
    @blueprint.attribute('fooBar', value: 'bar')

    @blueprint.synthesize(@el)
    assert_equal(1, @el.attributes.count)
    assert_equal('bar', @el.get('fooBar'))
  end

  def test_mapped_attribute
    @blueprint.mapped_attribute('foo') { color('bar') }
    assert_equal(1, @blueprint.mapped_attributes.count)

    attr = @blueprint.mapped_attributes['foo']
    assert_equal('foo', attr.name)
  end

  def test_mapped_attribute_value
    @blueprint.mapped_attribute('foo', value: 'white') { color('bar') }
    assert_equal(1, @blueprint.mapped_attributes.count)

    attr = @blueprint.mapped_attributes['foo']
    assert_equal('white', attr.value)
  end

  def test_mapped_attribute_synthesize
    @blueprint.mapped_attribute('foo', value: 'white') { color('bar') }
    assert_equal(1, @blueprint.mapped_attributes.count)

    @blueprint.synthesize(@el)

    assert_equal(1, @el.children.count)
    color_el = @el.children.first

    assert_equal('color', color_el.name)
    assert_equal('1.0', color_el.get('red'))
  end

  def test_element
    @blueprint.element('foo') { attribute 'bar' }
    assert_equal(1, @blueprint.elements.count)

    el = @blueprint.elements.first
    assert_equal('foo', el.name)
  end

  def test_element_synthesize
    @blueprint.element('foo') { attribute 'bar' }

    @blueprint.synthesize(@el)

    assert_equal(1, @el.children.count)
    child_el = @el.children.first

    assert_equal('foo', child_el.name)
    assert_equal(1, child_el.attributes.count)

    child_el.set('bar', 'baz')
    assert_equal('baz', child_el.get('bar'))
  end

  def test_root_element
    @blueprint.root_element('foo') { attribute 'bar' }
    refute_nil(@blueprint.root)

    el = @blueprint.root
    assert_equal('foo', el.name)
  end

  def test_root_element_synthesize
    @blueprint.root_element('foo') { attribute 'bar' }
    @blueprint.element('bar') {}

    @blueprint.synthesize(@el)

    assert_equal(2, @el.children.count)
    child_el = @el.children.first

    assert_equal(1, child_el.attributes.count)
    assert_equal(0, child_el.children.count)

    another_el = @el.children[1]
    assert_equal('bar', another_el.name)
  end

  def test_constraint
    @blueprint.constraint('foo', on: :parent)
    assert_equal(1, @blueprint.constraints.count)
    assert_equal(:parent, @blueprint.constraints['foo'])
  end

  def test_constraint_synthesize
    @blueprint.constraint('foo', on: :parent)
    @blueprint.synthesize(@el)

    assert_equal(0, @el.children.count)
  end

  def test_set_attribute
    @blueprint.attribute('fooBar')
    @blueprint.set_attribute('fooBar', 'bar')

    attr = @blueprint.attributes.first
    assert_equal('bar', attr.value)
  end

  def test_set_attribute_mapped
    @blueprint.mapped_attribute('foo') { color('bar') }
    @blueprint.set_attribute('foo', 'white')

    attr = @blueprint.mapped_attributes['foo']
    assert_equal('white', attr.value)
  end
end
