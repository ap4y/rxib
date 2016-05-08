RXib.define(:document) do
  attribute :type, default: 'com.apple.InterfaceBuilder3.CocoaTouch.XIB'
  attribute :version, default: '3.0'
  attribute :tools_version, default: '6211'
  attribute :system_version, default: '14A298i'
  attribute :target_runtime, default: 'iOS.CocoaTouch'
  attribute :property_access_control, default: 'none'
  attribute :use_autolayout, default: 'YES'
  attribute :use_trait_collections, default: 'YES'

  element :dependencies do
    element :plug_in do
      attribute :identifier, default: 'com.apple.InterfaceBuilder.IBCocoaTouchPlugin'
      attribute :version, default: '6204'
    end
  end

  element :objects, root: true do
    element :placeholder do
      attribute :placeholder_identifier, default: 'IBFilesOwner'
      attribute :id, default: '-1'
      attribute :user_label, default: "File's Owner"
    end
  end
end
