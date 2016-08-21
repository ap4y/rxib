require_relative 'test_helper'

class FontTest < Minitest::Test
  def test_system
    font = RXib::Font.font_for('System 15.3')
    assert_equal(RXib::Font::System, font.class)
    assert_equal('system', font.type)
    assert_equal('15.3', font.point_size)
  end

  def test_system_with_weight
    font = RXib::Font.font_for('System UltraLight 15.3')
    assert_equal(RXib::Font::System, font.class)
    assert_equal('system', font.type)
    assert_equal('15.3', font.point_size)
    assert_equal('ultraLight', font.weight)
  end

  def test_system_italic
    font = RXib::Font.font_for('System Italic 15.3')
    assert_equal(RXib::Font::System, font.class)
    assert_equal('italicSystem', font.type)
    assert_equal('15.3', font.point_size)
  end

  def test_styled
    font = RXib::Font.font_for('Caption1')
    assert_equal(RXib::Font::Styled, font.class)
    assert_equal('UICTFontTextStyleCaption1', font.style)
  end

  def test_custom
    font = RXib::Font.font_for('HelveticaNeue 27.1')
    assert_equal(RXib::Font::Custom, font.class)
    assert_equal('Helvetica Neue', font.family)
    assert_equal('HelveticaNeue', font.name)
    assert_equal('27.1', font.point_size)
  end

  def test_custom_with_weight
    font = RXib::Font.font_for('HelveticaNeue UltraLightItalic 27.1')
    assert_equal('Helvetica Neue', font.family)
    assert_equal('HelveticaNeue-UltraLightItalic', font.name)
    assert_equal('27.1', font.point_size)
  end

  def test_assign_attributes_no_property
    font = RXib::Font.font_for('System Bold 15.3')
    el = Oga::XML::Element.new
    RXib::Font.assign_attributes(el, font)

    assert_equal('system', el.get(:type))
    assert_equal('bold', el.get(:weight))
    assert_equal('15.3', el.get(:pointSize))
  end

  def test_assign_attributes_with_property
    el = Oga::XML::Element.new
    font = RXib::Font.font_for('System Bold 15.3')
    RXib::Font.assign_attributes(el, font)

    font = RXib::Font.font_for('Caption1')
    RXib::Font.assign_attributes(el, font)

    assert_nil(el.get(:type))
    assert_nil(el.get(:weight))
    assert_nil(el.get(:pointSize))
    assert_equal('UICTFontTextStyleCaption1', el.get(:style))
  end

  def test_assign_attributes_with_property_reassign
    el = Oga::XML::Element.new
    font = RXib::Font.font_for('System Bold 15.4')
    RXib::Font.assign_attributes(el, font)

    font = RXib::Font.font_for('System 15.3')
    RXib::Font.assign_attributes(el, font)

    assert_equal('system', el.get(:type))
    assert_nil(el.get(:weight))
    assert_equal('15.3', el.get(:pointSize))
  end
end
