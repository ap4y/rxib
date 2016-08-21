module BehavesAsBaseElement
  def test_id
    refute_nil(@el.get('id'))
  end

  def test_content_mode
    assert_equal('scaleToFill', @el.get('contentMode'))
  end

  def test_attributes
    attrs = %w(id itemId contentMode tag userInteractionEnabled
               alpha opaque hidden clipsSubviews
               translatesAutoresizingMaskIntoConstraints
               horizontalHuggingPriority verticalHuggingPriority)
    assert_equal(attrs, @el.blueprint.attributes.map(&:name))
  end

  def test_attributes
    assert_equal('subviews', @el.blueprint.root.name)
  end

  def test_attributes
    constraints = {
      'width'            => :self,
      'height'           => :self,
      'centerX'          => :parent,
      'centerY'          => :parent,
      'horizontalLayout' => :parent,
      'verticalLayout'   => :parent
    }
    assert_equal(constraints, @el.blueprint.constraints)
  end
end
