RXib.define(:view) do
  attribute :id, default: RXib.generate_id
  attribute :content_mode, default: 'scaleToFill'
  attribute :tag
  attribute :user_interaction_enabled
  attribute :hidden
  attribute :clips_subviews

  mapped_attribute :background_color do |value|
    color key: :background_color, value: value
  end

  mapped_attribute :tint_color do |value|
    color key: :tint_color, value: value
  end

  element :subviews, root: true do
  end
end
