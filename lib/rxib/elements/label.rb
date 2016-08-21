module RXib
  module Elements
    class Label < Base
      blueprint('label') do
        attribute 'text'
        attribute 'textAlignment', value: 'natural'
        attribute 'numberOfLines'
        attribute 'enabled'
        attribute 'highlighted'
        attribute 'baselineAdjustment', value: 'alignBaselines'
        attribute 'lineBreakMode', value: 'tailTruncation'
        attribute 'adjustsFontSizeToFit', value: 'NO'

        attribute 'fixedFrame', value: 'YES'

        mapped_attribute 'textColor', value: 'black' do
          color 'textColor'
        end

        mapped_attribute 'highlightedColor' do
          color 'highlightedColor'
        end

        mapped_attribute 'font', value: 'System 17.0' do
          font_description
        end

        set_attribute('opaque', 'NO')
        set_attribute('userInteractionEnabled', 'NO')
        set_attribute('contentMode', 'left')
        set_attribute('horizontalHuggingPriority', '251')
        set_attribute('verticalHuggingPriority', '251')
        set_attribute('translatesAutoresizingMaskIntoConstraints', 'NO')
      end
    end
  end
end
