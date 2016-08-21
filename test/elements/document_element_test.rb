require_relative '../test_helper'

class DocumentElementTest < Minitest::Test
  def setup
    @el = RXib::Elements::Document.new
    @el.synthesize
  end

  def test_name
    assert_equal('document', @el.name)
  end

  def test_type
    assert_equal('com.apple.InterfaceBuilder3.CocoaTouch.XIB',
                 @el.get('type'))
  end

  def test_type
    assert_equal('com.apple.InterfaceBuilder3.CocoaTouch.XIB',
                 @el.get('type'))
  end

  def test_version
    assert_equal('3.0', @el.get('version'))
  end

  def test_toolsVersion
    assert_equal('10117', @el.get('toolsVersion'))
  end

  def test_systemVersion
    assert_equal('15E65', @el.get('systemVersion'))
  end

  def test_targetRuntime
    assert_equal('iOS.CocoaTouch', @el.get('targetRuntime'))
  end

  def test_propertyAccessControl
    assert_equal('none', @el.get('propertyAccessControl'))
  end

  def test_useAutolayout
    assert_equal('YES', @el.get('useAutolayout'))
  end

  def test_useTraitCollections
    assert_equal('YES', @el.get('useTraitCollections'))
  end

  def test_dependencies
    el = @el.children.find { |e| e.name == 'dependencies' }
    refute_nil(el)

    assert_equal(2, el.children.count)

    child_el = el.children.first
    assert_equal('deployment', child_el.name)
    assert_equal('iOS', child_el.get('identifier'))

    child_el = el.children.last
    assert_equal('plugIn', child_el.name)
    assert_equal('com.apple.InterfaceBuilder.IBCocoaTouchPlugin',
                 child_el.get('identifier'))
    assert_equal('10085', child_el.get('version'))
  end

  def test_dependencies
    el = @el.root
    refute_nil(el)
    assert_equal('objects', el.name)

    assert_equal(2, el.children.count)

    child_el = el.children.first
    assert_equal('placeholder', child_el.name)
    assert_equal('IBFilesOwner', child_el.get('placeholderIdentifier'))
    assert_equal('-1', child_el.get('id'))
    assert_equal("File's Owner", child_el.get('userLabel'))

    child_el = el.children.last
    assert_equal('placeholder', child_el.name)
    assert_equal('IBFirstResponder', child_el.get('placeholderIdentifier'))
    assert_equal('-2', child_el.get('id'))
    assert_equal("UIResponder", child_el.get('userLabel'))
  end
end
