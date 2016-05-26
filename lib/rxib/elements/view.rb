RXib.define(:view) do
  property :id, default: RXib.generate_id
  property :content_mode, default: 'scaleToFill'
  # property :tag
  # property :user_interaction_enabled
  # property :hidden
  # property :clips_subviews
  property :item_id

  mapped_property :background_color do |value|
    color key: :background_color, value: value
  end

  mapped_property :tint_color do |value|
    color key: :tint_color, value: value
  end

  element :autoresizing_mask do
    property :key, default: 'autoresizingMask'
    property :flexibleMaxX, default: 'YES'
    property :flexibleMaxY, default: 'YES'
  end

  element :subviews, root: true do
  end

  element :constraints do
  end

  self.background_color = 'white'
end
