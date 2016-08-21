require_relative 'test_helper'

class ConstraintTest < Minitest::Test
  class Element < Oga::XML::Element
    include RXib::DSL

    blueprint do
      attribute 'id'
      attribute 'itemId'
    end
  end

  def setup
    @el = Element.new
    @el.set('id', '1')

    @child_el = Element.new
    @child_el.set('id', '2')
    @child_el.set('itemId', 'bar')

    @another_el = Element.new
    @another_el.set('id', '3')
    @another_el.set('itemId', 'foo')

    @el.children << @child_el
    @el.children << @another_el
  end

  def test_lookup_item
    el_id = RXib::Constraint.lookup_item('|', @child_el)
    assert_equal('1', el_id)

    el_id = RXib::Constraint.lookup_item('foo', @child_el)
    assert_equal('3', el_id)
  end

  def test_constant
    constraint = RXib::Constraint::Constant.new(@child_el, 'width', ['10'])
    assert_equal('width', constraint.name)
    assert_equal('10', constraint.constant)
  end

  def test_relative
    constraint =
      RXib::Constraint::Relative.new(@child_el, 'centerX', ['foo', '10'])
    assert_equal('centerX', constraint.name)
    assert_equal('2', constraint.first_item)
    assert_equal('3', constraint.second_item)
    assert_equal('10', constraint.constant)

    constraint = RXib::Constraint::Relative.new(@child_el, 'centerX', ['foo'])
    assert_equal('centerX', constraint.name)
    assert_equal('2', constraint.first_item)
    assert_equal('3', constraint.second_item)
    assert_equal('0', constraint.constant)
  end

  def test_relative_right
    constraint =
      RXib::Constraint::Align.new(@child_el, 'centerX', ['foo', '10'])
    refute(constraint.parent_aligned?)
    assert_equal('centerX', constraint.name)
    assert_equal('10', constraint.constant)
    assert_equal(:right, constraint.constant_position)
    assert_equal('2', constraint.first_item)
    assert_equal('3', constraint.second_item)
    assert_equal(%w(leading trailing), constraint.horizontal_attributes)
    assert_equal(%w(top bottom), constraint.vertical_attributes)
  end

  def test_relative_right_parent
    constraint = RXib::Constraint::Align.new(@child_el, 'centerX', ['|', '10'])
    assert(constraint.parent_aligned?)
    assert_equal('centerX', constraint.name)
    assert_equal('10', constraint.constant)
    assert_equal(:right, constraint.constant_position)
    assert_equal('2', constraint.first_item)
    assert_equal('1', constraint.second_item)
    assert_equal(%w(leading leading), constraint.horizontal_attributes)
    assert_equal(%w(top top), constraint.vertical_attributes)
  end

  def test_relative_left
    constraint =
      RXib::Constraint::Align.new(@child_el, 'centerX', ['10', 'foo'])
    refute(constraint.parent_aligned?)
    assert_equal('centerX', constraint.name)
    assert_equal('10', constraint.constant)
    assert_equal(:left, constraint.constant_position)
    assert_equal('3', constraint.first_item)
    assert_equal('2', constraint.second_item)
    assert_equal(%w(leading trailing), constraint.horizontal_attributes)
    assert_equal(%w(top bottom), constraint.vertical_attributes)
  end

  def test_relative_left_parent
    constraint = RXib::Constraint::Align.new(@child_el, 'centerX', ['10', '|'])
    assert(constraint.parent_aligned?)
    assert_equal('centerX', constraint.name)
    assert_equal('10', constraint.constant)
    assert_equal(:left, constraint.constant_position)
    assert_equal('1', constraint.first_item)
    assert_equal('2', constraint.second_item)
    assert_equal(%w(trailing trailing), constraint.horizontal_attributes)
    assert_equal(%w(bottom bottom), constraint.vertical_attributes)
  end

  def test_constraints_for_center
    constraints = RXib::Constraint.constraints_for('centerX', 'foo-10', @child_el)
    assert_equal(1, constraints.count)
    constraint = constraints.first

    assert_kind_of(RXib::Constraint::Relative, constraint)
    assert_equal('2', constraint.first_item)
    assert_equal('3', constraint.second_item)
    assert_equal('10', constraint.constant)

    constraints = RXib::Constraint.constraints_for('centerY', '|', @child_el)
    assert_equal(1, constraints.count)
    constraint = constraints.first

    assert_kind_of(RXib::Constraint::Relative, constraint)
    assert_equal('2', constraint.first_item)
    assert_equal('1', constraint.second_item)
    assert_equal('0', constraint.constant)
  end

  def test_constraints_for_size
    constraints = RXib::Constraint.constraints_for('width', '10', @child_el)
    assert_equal(1, constraints.count)
    constraint = constraints.first

    assert_kind_of(RXib::Constraint::Constant, constraint)
    assert_equal('10', constraint.constant)
  end

  def test_constraints_for_center
    constraints = RXib::Constraint.constraints_for('centerX', '|', @child_el)
    assert_equal(1, constraints.count)
    constraint = constraints.first

    assert_kind_of(RXib::Constraint::Relative, constraint)
    assert_equal('0', constraint.constant)
    assert_equal('2', constraint.first_item)
    assert_equal('1', constraint.second_item)
  end

  def test_constraints_for_layout
    constraints = RXib::Constraint.constraints_for('horizontalLayout',
                                                   '|-10', @child_el)
    assert_equal(1, constraints.count)
    constraint = constraints.first

    assert_kind_of(RXib::Constraint::Align, constraint)
    assert_equal('10', constraint.constant)
    assert_equal('2', constraint.first_item)
    assert_equal('1', constraint.second_item)

    constraints = RXib::Constraint.constraints_for('verticalLayout',
                                                   'foo-20', @child_el)
    assert_equal(1, constraints.count)
    constraint = constraints.first

    assert_kind_of(RXib::Constraint::Align, constraint)
    assert_equal('20', constraint.constant)
    assert_equal('2', constraint.first_item)
    assert_equal('3', constraint.second_item)
  end

  def test_constraints_for_layout_bounded
    constraints = RXib::Constraint.constraints_for('horizontalLayout',
                                                   '|-10-@-20-|', @child_el)
    assert_equal(2, constraints.count)

    constraint = constraints.first
    assert_kind_of(RXib::Constraint::Align, constraint)
    assert_equal('10', constraint.constant)
    assert_equal('2', constraint.first_item)
    assert_equal('1', constraint.second_item)

    constraint = constraints.last
    assert_kind_of(RXib::Constraint::Align, constraint)
    assert_equal('20', constraint.constant)
    assert_equal('1', constraint.first_item)
    assert_equal('2', constraint.second_item)
  end

  def test_replacement_for_constant
    constraint = RXib::Constraint::Constant.new(@child_el, 'width', ['10'])

    other = RXib::Constraint::Constant.new(@child_el, 'width', ['20'])
    assert(constraint.replacement_for?(other))

    other = RXib::Constraint::Constant.new(@child_el, 'height', ['20'])
    refute(constraint.replacement_for?(other))

    other = RXib::Constraint::Relative.new(@child_el, 'centerX', ['foo', '10'])
    refute(constraint.replacement_for?(other))
  end

  def test_replacement_for_relative
    constraint = RXib::Constraint::Relative.new(@child_el, 'centerX', ['foo', '10'])

    other = RXib::Constraint::Relative.new(@child_el, 'centerX', ['foo', '20'])
    assert(constraint.replacement_for?(other))

    other = RXib::Constraint::Relative.new(@another_el, 'centerX', ['foo', '20'])
    refute(constraint.replacement_for?(other))

    other = RXib::Constraint::Relative.new(@child_el, 'centerY', ['bar', '10'])
    refute(constraint.replacement_for?(other))

    other = RXib::Constraint::Relative.new(@child_el, 'centerY', ['foo', '10'])
    refute(constraint.replacement_for?(other))

    other = RXib::Constraint::Constant.new(@child_el, 'height', ['20'])
    refute(constraint.replacement_for?(other))
  end

  def test_replacement_for_align
    constraint =
      RXib::Constraint::Align.new(@child_el, 'centerX', ['foo', '10'])

    other = RXib::Constraint::Align.new(@child_el, 'centerX', ['foo', '20'])
    assert(constraint.replacement_for?(other))

    other = RXib::Constraint::Align.new(@child_el, 'centerX', ['bar', '20'])
    refute(constraint.replacement_for?(other))

    other = RXib::Constraint::Align.new(@another_el, 'centerX', ['foo', '20'])
    refute(constraint.replacement_for?(other))

    other = RXib::Constraint::Align.new(@child_el, 'centerX', ['20', 'foo'])
    refute(constraint.replacement_for?(other))

    other = RXib::Constraint::Constant.new(@child_el, 'height', ['20'])
    refute(constraint.replacement_for?(other))
  end
end
