RXib.define(:base_element) do
  property :id, default: RXib.generate_id
  property :item_id

  property :content_mode, default: 'scaleToFill'
  property :tag

  property :user_interaction_enabled

  property :alpha

  mapped_property :background_color do |value|
    color key: :background_color, value: value
  end

  mapped_property :tint_color do |value|
    color key: :tint_color, value: value
  end

  property :opaque
  property :hidden
  property :clips_subviews

  property :translates_autoresizing_mask_into_constraints
  property :horizontal_hugging_priority
  property :vertical_hugging_priority

  mapped_property :horizontal_layout do |value|
    constraint :horizontal, value: value, on: :parent
  end

  mapped_property :vertical_layout do |value|
    constraint :vertical, value: value, on: :parent
  end

  mapped_property :width do |value|
    constraint :width, value: value, on: :self
  end

  mapped_property :height do |value|
    constraint :height, value: value, on: :self
  end

  mapped_property :centerX do |value|
    constraint :centerX, value: value, on: :parent
  end

  mapped_property :centerY do |value|
    constraint :centerY, value: value, on: :parent
  end

  element :subviews, root: true do
  end

  element :constraints do
  end
end
