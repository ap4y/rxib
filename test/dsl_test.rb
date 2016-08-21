require_relative 'test_helper'

class DSLTest < Minitest::Test
  class Element < Oga::XML::Element
    include RXib::DSL

    blueprint('foo') do
      attribute 'foo', value: 'baz'

      mapped_attribute 'bar', value: 'white' do
        color('tintColor')
      end

      constraint 'width', on: :self
      constraint 'centerX', on: :parent

      element 'foo' do
        attribute 'foo'

        element 'bar' do
        end
      end
    end
  end

  class SubElement < Element
    blueprint do
      attribute 'baz'

      root_element 'subViews' do
      end

      set_attribute('foo', 'bar')
      set_attribute('bar', 'black')
    end
  end

  def setup
    @el = Element.new
    @el.synthesize
  end

  def test_blueprint
    blueprint = Element.class_blueprint
    refute_nil(blueprint)
    assert_equal(1, blueprint.attributes.count)
  end

  def test_synthesize
    assert_equal('foo', @el.name)
    assert_equal(1, @el.attributes.count)
    assert_equal(2, @el.children.count)

    el = @el.children.first
    assert_equal('color', el.name)

    el = @el.children[1]
    assert_equal('foo', el.name)
  end

  def test_set_attribute
    @el.set('foo', 'bar')
    assert_equal('bar', @el.get('foo'))
  end

  def test_set_mapped_attribute
    @el.set('bar', 'black')
    el = @el.children.first
    assert_equal('0.0', el.get('red'))
  end

  def test_inheritance
    el = SubElement.new
    el.synthesize

    assert_equal(1, @el.attributes.count)
    assert_equal(2, @el.children.count)
    assert_equal('baz', @el.get('foo'))
    assert_equal('1.0', @el.children.first.get('red'))

    assert_equal(2, el.attributes.count)
    assert_equal(3, el.children.count)
    assert_equal('bar', el.get('foo'))
    assert_equal('0.0', el.children[1].get('red'))
  end

  def test_root
    el = SubElement.new
    @el.root = el

    assert(el.root?)
    refute(@el.root?)
    assert_equal(@el, el.parent)
    assert_equal(el, @el.root)
    assert_equal(el, el.root)
  end
end
