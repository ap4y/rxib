RXib.define(:label) do
  property :id, default: RXib.generate_id
  property :content_mode, default: 'left'
  property :opaque, default: 'NO'
  property :user_interaction_enabled, default: 'NO'
  property :horizontal_hugging_priority, default: '251'
  property :vertical_hugging_priority, default: '251'
  property :fixed_frame, default: 'YES'
  property :text_alignment, default: 'natural'
  property :line_break_mode, default: 'tailTruncation'
  property :baseline_adjustment, default: 'alignBaselines'
  property :adjusts_font_size_to_fit, default: 'NO'
  property :translates_autoresizing_mask_into_constraints, default: 'NO'
  property :text
  property :item_id

  mapped_property :text_color do |value|
    color key: :text_color, value: value
  end

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

  element :font_description do
    property :key, default: 'fontDescription'
    property :type, default: 'system'
    property :point_size, default: '17'
  end

  element :constraints do
  end

  self.text_color = 'black'
end
