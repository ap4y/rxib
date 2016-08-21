module RXib
  module Elements
    class Document < Oga::XML::Element
      include RXib::DSL

      blueprint('document') do
        attribute 'type', value: 'com.apple.InterfaceBuilder3.CocoaTouch.XIB'
        attribute 'version', value: '3.0'
        attribute 'toolsVersion', value: '10117'
        attribute 'systemVersion', value: '15E65'
        attribute 'targetRuntime', value: 'iOS.CocoaTouch'
        attribute 'propertyAccessControl', value: 'none'
        attribute 'useAutolayout', value: 'YES'
        attribute 'useTraitCollections', value: 'YES'

        element 'dependencies' do
          element 'deployment' do
            attribute 'identifier', value: 'iOS'
          end

          element 'plugIn' do
            attribute 'identifier', value: 'com.apple.InterfaceBuilder.IBCocoaTouchPlugin'
            attribute 'version', value: '10085'
          end
        end

        root_element 'objects' do
          element 'placeholder' do
            attribute 'placeholderIdentifier', value: 'IBFilesOwner'
            attribute 'id', value: '-1'
            attribute 'userLabel', value: "File's Owner"
          end

          element 'placeholder' do
            attribute 'placeholderIdentifier', value: 'IBFirstResponder'
            attribute 'id', value: '-2'
            attribute 'userLabel', value: 'UIResponder'
          end
        end
      end
    end
  end
end
