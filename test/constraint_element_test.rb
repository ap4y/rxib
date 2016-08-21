require_relative 'test_helper'

class ConstraintElementTest < Minitest::Test
  class Element < Oga::XML::Element
    include RXib::DSL

    blueprint do
      attribute 'id'
      attribute 'itemId'

      constraint 'width', on: :self
    end
  end

  def setup
    @parent_el = Element.new
    @parent_el.synthesize
    @parent_el.set('id', '1')

    @el = Element.new
    @el.synthesize
    @el.set('id', '2')

    @parent_el.children << @el
  end

  def test_constraint
    constraint = RXib::Constraint::Constant.new(@el, 'width', ['10'])
    el = RXib::Constraint::Element.new(constraint)
    assert_equal(constraint, el.constraint)
  end

  def test_width
    constraint = RXib::Constraint::Constant.new(@el, 'width', ['10'])
    el = RXib::Constraint::Element.new(constraint)
    assert_equal('width', el.get('firstAttribute'))
    assert_equal('10', el.get('constant'))
  end

  def test_height
    constraint = RXib::Constraint::Constant.new(@el, 'height', ['10'])
    el = RXib::Constraint::Element.new(constraint)
    assert_equal('height', el.get('firstAttribute'))
    assert_equal('10', el.get('constant'))
  end

  def test_center_x
    constraint = RXib::Constraint::Relative.new(@el, 'centerX', ['|', '10'])
    el = RXib::Constraint::Element.new(constraint)
    assert_equal('centerX', el.get('firstAttribute'))
    assert_equal('centerX', el.get('secondAttribute'))
    assert_equal('2', el.get('firstItem'))
    assert_equal('1', el.get('secondItem'))
    assert_equal('10', el.get('constant'))
  end

  def test_center_y
    constraint = RXib::Constraint::Relative.new(@el, 'centerY', ['|', '10'])
    el = RXib::Constraint::Element.new(constraint)
    assert_equal('centerY', el.get('firstAttribute'))
    assert_equal('centerY', el.get('secondAttribute'))
    assert_equal('2', el.get('firstItem'))
    assert_equal('1', el.get('secondItem'))
    assert_equal('10', el.get('constant'))
  end

  def test_horizontal_layout
    constraint =
      RXib::Constraint::Align.new(@el, 'horizontalLayout', ['|', '10'])
    el = RXib::Constraint::Element.new(constraint)
    assert_equal('leading', el.get('firstAttribute'))
    assert_equal('leading', el.get('secondAttribute'))
    assert_equal('2', el.get('firstItem'))
    assert_equal('1', el.get('secondItem'))
    assert_equal('10', el.get('constant'))
  end

  def test_vertical_layout
    constraint =
      RXib::Constraint::Align.new(@el, 'verticalLayout', ['|', '10'])
    el = RXib::Constraint::Element.new(constraint)
    assert_equal('top', el.get('firstAttribute'))
    assert_equal('top', el.get('secondAttribute'))
    assert_equal('2', el.get('firstItem'))
    assert_equal('1', el.get('secondItem'))
    assert_equal('10', el.get('constant'))
  end
end
