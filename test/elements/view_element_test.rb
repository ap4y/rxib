require_relative '../test_helper'
require_relative 'common'

class ViewElementTest < Minitest::Test
  include BehavesAsBaseElement

  def setup
    @el = RXib::Elements::View.new
    @el.synthesize
  end

  def test_name
    assert_equal('view', @el.name)
  end

  def test_background_color
    assert_equal('white',
                 @el.blueprint.mapped_attributes['backgroundColor'].value)
  end

  def test_autoresizingMask
    el = @el.children.last
    assert_equal('autoresizingMask', el.name)
    assert_equal('autoresizingMask', el.get('key'))
    assert_equal('YES', el.get('flexibleMaxX'))
    assert_equal('YES', el.get('flexibleMaxY'))
  end
end
