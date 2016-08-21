require_relative 'test_helper'

class ColorTest < Minitest::Test
  def test_color
    color = RXib::Color.new('white')
    assert_equal('1.0', color.red)
    assert_equal('1.0', color.green)
    assert_equal('1.0', color.blue)
    assert_equal('1.0', color.alpha)

    color = RXib::Color.new('red')
    assert_equal('1.0', color.red)
    assert_equal('0.0', color.green)
    assert_equal('0.0', color.blue)
    assert_equal('1.0', color.alpha)
  end

  def test_assign_attribute
    color = RXib::Color.new('white')
    el = Oga::XML::Element.new
    RXib::Color.assign_attributes(el, color)
    assert_equal('1.0', el.get('red'))
    assert_equal('1.0', el.get('green'))
    assert_equal('1.0', el.get('blue'))
    assert_equal('1.0', el.get('alpha'))
  end
end
