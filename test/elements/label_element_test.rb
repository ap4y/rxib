require_relative '../test_helper'
require_relative 'common'

class LabelElementTest < Minitest::Test
  include BehavesAsBaseElement

  def setup
    @el = RXib::Elements::Label.new
    @el.synthesize
  end

  def test_name
    assert_equal('label', @el.name)
  end

  def test_content_mode
    assert_equal('left', @el.get('contentMode'))
  end

  def test_text_alignment
    assert_equal('natural', @el.get('textAlignment'))
  end

  def test_baseline_adjustment
    assert_equal('alignBaselines', @el.get('baselineAdjustment'))
  end

  def test_line_break_mode
    assert_equal('tailTruncation', @el.get('lineBreakMode'))
  end

  def test_adjusts_font_size_to_it
    assert_equal('NO', @el.get('adjustsFontSizeToFit'))
  end

  def test_fixed_frame
    assert_equal('YES', @el.get('fixedFrame'))
  end

  def test_opaque
    assert_equal('NO', @el.get('opaque'))
  end

  def test_userInteractionEnabled
    assert_equal('NO', @el.get('userInteractionEnabled'))
  end

  def test_horizontalHuggingPriority
    assert_equal('251', @el.get('horizontalHuggingPriority'))
  end

  def test_verticalHuggingPriority
    assert_equal('251', @el.get('verticalHuggingPriority'))
  end

  def test_translatesAutoresizingMaskIntoConstraints
    assert_equal('NO', @el.get('translatesAutoresizingMaskIntoConstraints'))
  end

  def test_textColor
    assert_equal('black',
                 @el.blueprint.mapped_attributes['textColor'].value)
  end

  def test_font
    assert_equal('System 17.0',
                 @el.blueprint.mapped_attributes['font'].value)
  end

  def test_other_attributes
    attrs = @el.blueprint.attributes.map(&:name)
    assert_includes(attrs, 'text')
    assert_includes(attrs, 'numberOfLines')
    assert_includes(attrs, 'enabled')
    assert_includes(attrs, 'highlighted')

    refute_nil(@el.blueprint.mapped_attributes['highlightedColor'])
  end
end
