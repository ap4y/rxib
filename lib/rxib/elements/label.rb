RXib.define(:label, extends: :base_element) do
  property :text
  property :text_alignment, default: 'natural'
  property :number_of_lines
  property :enabled
  property :highlighted
  property :baseline_adjustment, default: 'alignBaselines'
  property :line_break_mode, default: 'tailTruncation'
  property :adjusts_font_size_to_fit, default: 'NO'

  property :fixed_frame, default: 'YES'

  mapped_property :text_color do |value|
    color key: :text_color, value: value
  end

  mapped_property :highlighted_color do |value|
    color key: :highlighted_color, value: value
  end

  mapped_property :font do |value|
    font_description :value
  end

  # element :font_description do
  #   property :key, default: 'fontDescription'
  #   property :type, default: 'system'
  #   property :weight
  #   property :point_size, default: '17'
  # end

  self.opaque = 'NO'
  self.user_interaction_enabled = 'NO'
  self.content_mode = 'left'
  self.horizontal_hugging_priority = '251'
  self.vertical_hugging_priority = '251'
  self.translates_autoresizing_mask_into_constraints = 'NO'

  self.text_color = 'black'
  self.font = 'System 17.0'
end
