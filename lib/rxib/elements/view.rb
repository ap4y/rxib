RXib.define(:view) do
  attribute :content_mode, default: 'scaleToFill'
  attribute :id, default: RXib.generate_id

  # element :rect do
  #   attribute :key, default: 'frame'
  #   attribute :x, default: '0.0'
  #   attribute :y, default: '0.0'
  #   attribute :width, default: '600'
  #   attribute :height, default: '600'
  # end

  # element :autoresizing_mask do
  #   attribute :key, default: 'autoresizingMask'
  #   attribute :flexibleMaxX, default: 'YES'
  #   attribute :flexibleMaxY, default: 'YES'
  # end

  # element :color do
  #   attribute :key, default: 'backgroundColor'
  #   attribute :white, default: '1'
  #   attribute :alpha, default: '1'
  #   attribute :color_space, default: 'calibratedWhite'
  # end

  element :subviews, root: true do
  end
end
