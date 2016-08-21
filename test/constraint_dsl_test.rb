require_relative 'test_helper'

class ConstraintDSLTest < Minitest::Test
  class Element < Oga::XML::Element
    include RXib::DSL
    include RXib::Constraint::DSL

    blueprint do
      attribute 'id'
      attribute 'itemId'

      constraint 'width', on: :self
      constraint 'horizontalLayout', on: :parent
    end
  end

  def setup
    @parent_el = Element.new
    @parent_el.synthesize
    @parent_el.set('id', '1')

    @el = Element.new
    @el.synthesize
    @el.set('id', '2')
    @el.set('itemId', 'foo')

    @parent_el.children << @el
  end

  def test_constraints
    constraint = RXib::Constraint::Constant.new(@el, 'width', ['10'])
    @el.assign_constraint(constraint)

    assert_equal(1, @el.constraints.children.count)
  end

  def test_update_constraint
    constraint = RXib::Constraint::Constant.new(@el, 'width', ['10'])
    @el.assign_constraint(constraint)
    constraint_el = @el.constraints.children.first
    assert_equal('10', constraint_el.get('constant'))

    constraint = RXib::Constraint::Constant.new(@el, 'width', ['20'])
    @el.assign_constraint(constraint)
    assert_equal(1, @el.constraints.children.count)
    constraint_el = @el.constraints.children.first
    assert_equal('20', constraint_el.get('constant'))
  end

  def test_set_constraint
    @el.set('itemId', 'foo')
    assert_equal('foo', @el.get('itemId'))

    @el.set('width', '100')
    assert_equal(1, @el.constraints.children.count)

    cel = @el.constraints.children.first
    assert('100', cel.get('constant'))
  end

  def test_constraint_set_on_parent
    @el.set('horizontalLayout', '|-10')
    assert_equal(0, @el.constraints.children.count)
    assert_equal(1, @parent_el.constraints.children.count)
  end
end
