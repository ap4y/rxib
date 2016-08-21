require_relative 'test_helper'

class AttributeTest < Minitest::Test
  def test_value
    attr = RXib::Attribute.new('foo', 'bar').synthesize
    assert_equal('foo', attr.name)
    assert_equal('bar', attr.value)
  end

  def test_value_callable
    val = 0
    rattr = RXib::Attribute.new('foo', ->{ "#{val += 1}" })

    attr = rattr.synthesize
    assert_equal('foo', attr.name)
    assert_equal('1', attr.value)


    attr = rattr.synthesize
    assert_equal('foo', attr.name)
    assert_equal('2', attr.value)
  end
end
