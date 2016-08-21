require_relative 'test_helper'

class MappedAttributeTest < Minitest::Test
  def test_color
    attribute = RXib::MappedAttribute.new('foo') { color('textColor') }
    el = attribute.synthesize

    assert_equal('color', el.name)
    assert_equal('textColor', el.get('key'))
    assert_equal('calibratedRGB', el.get('colorSpace'))
  end

  def test_color_set
    attribute = RXib::MappedAttribute.new('foo') { color('textColor') }
    el = attribute.synthesize

    el.set('foo', 'black')
    assert_equal('0.0', el.get('red'))
    assert_equal('0.0', el.get('green'))
    assert_equal('0.0', el.get('blue'))
    assert_equal('1.0', el.get('alpha'))

    el.set('foo', 'white')
    assert_equal('1.0', el.get('red'))
    assert_equal('1.0', el.get('green'))
    assert_equal('1.0', el.get('blue'))
    assert_equal('1.0', el.get('alpha'))
  end

  def test_color_value
    attribute = RXib::MappedAttribute.new('foo', value: 'white') do
      color('textColor')
    end
    el = attribute.synthesize

    assert_equal('color', el.name)
    assert_equal('textColor', el.get('key'))
    assert_equal('calibratedRGB', el.get('colorSpace'))
    assert_equal('1.0', el.get('red'))
  end

  def test_font
    attribute = RXib::MappedAttribute.new('foo') { font_description }
    el = attribute.synthesize

    assert_equal('fontDescription', el.name)
    assert_equal('fontDescription', el.get('key'))
  end

  def test_font_set
    attribute = RXib::MappedAttribute.new('foo') { font_description }
    el = attribute.synthesize

    el.set('foo', 'System 15.3')
    assert_equal('system', el.get('type'))
    assert_equal('15.3', el.get('pointSize'))

    el.set('foo', 'Caption1')
    assert_nil(el.get('type'))
    assert_nil(el.get('pointSize'))
    assert_equal('UICTFontTextStyleCaption1', el.get('style'))
  end

  def test_font_value
    attribute = RXib::MappedAttribute.new('foo', value: 'Caption1') do
      font_description
    end
    el = attribute.synthesize

    assert_equal('fontDescription', el.name)
    assert_equal('fontDescription', el.get('key'))
    assert_equal('UICTFontTextStyleCaption1', el.get('style'))
  end
end
