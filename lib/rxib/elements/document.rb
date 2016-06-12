RXib.define(:document) do
  property :type, default: 'com.apple.InterfaceBuilder3.CocoaTouch.XIB'
  property :version, default: '3.0'
  property :tools_version, default: '10117'
  property :system_version, default: '15E65'
  property :target_runtime, default: 'iOS.CocoaTouch'
  property :property_access_control, default: 'none'
  property :use_autolayout, default: 'YES'
  property :use_trait_collections, default: 'YES'

  element :dependencies do
    element :deployment do
      property :identifier, default: 'iOS'
    end

    element :plug_in do
      property :identifier, default: 'com.apple.InterfaceBuilder.IBCocoaTouchPlugin'
      property :version, default: '10085'
    end
  end

  element :objects, root: true do
    element :placeholder do
      property :placeholder_identifier, default: 'IBFilesOwner'
      property :id, default: '-1'
      property :user_label, default: "File's Owner"
    end

    element :placeholder do
      property :placeholder_identifier, default: 'IBFirstResponder'
      property :id, default: '-2'
      property :user_label, default: 'UIResponder'
    end
  end
end
