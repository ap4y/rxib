module RXib
  module Elements
    class Base < Oga::XML::Element
      include RXib::DSL
      include RXib::Constraint::DSL

      blueprint do
        attribute 'id', value: ->{ RXib.generate_id }
        attribute 'itemId'

        root_element 'subviews' do
        end

        attribute 'contentMode', value: 'scaleToFill'
        attribute 'tag'

        attribute 'userInteractionEnabled'

        attribute 'alpha'

        mapped_attribute 'backgroundColor' do
          color 'backgroundColor'
        end

        mapped_attribute 'tintColor' do
          color 'tintColor'
        end

        attribute 'opaque'
        attribute 'hidden'
        attribute 'clipsSubviews'

        attribute 'translatesAutoresizingMaskIntoConstraints'
        attribute 'horizontalHuggingPriority'
        attribute 'verticalHuggingPriority'

        constraint 'horizontalLayout', on: :parent
        constraint 'verticalLayout', on: :parent

        constraint 'width', on: :self
        constraint 'height', on: :self

        constraint 'centerX', on: :parent
        constraint 'centerY', on: :parent
      end
    end
  end
end
