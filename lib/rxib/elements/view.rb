module RXib
  module Elements
    class View < Base
      blueprint('view') do
        element 'autoresizingMask' do
          attribute 'key', value: 'autoresizingMask'
          attribute 'flexibleMaxX', value: 'YES'
          attribute 'flexibleMaxY', value: 'YES'
        end

        set_attribute('backgroundColor', 'white')
      end
    end
  end
end
