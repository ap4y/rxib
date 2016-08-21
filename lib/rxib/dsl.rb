require './lib/rxib/blueprint'

module RXib
  module DSL
    module ClassMethods
      attr_accessor :class_blueprint

      def blueprint(name = nil, &block)
        blueprint = @class_blueprint || Blueprint.new
        blueprint.name = name
        blueprint.instance_eval(&block)
        @class_blueprint = blueprint
      end

      def inherited(child_class)
        child_class.class_blueprint = @class_blueprint.dup
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def blueprint
      self.class.class_blueprint
    end

    def synthesize
      blueprint.synthesize(self)
    end

    def set(name, value)
      if blueprint.mapped_attributes.key?(name)
        child = children.find do |el|
          el.respond_to?(:mapping_key) && el.mapping_key == name
        end
        child.set(name, value) if child
        return
      end

      super(name, value)
    end

    def root=(el)
      @root_el = el
      children << el
    end

    def root
      @root_el || self
    end

    def root?
      parent && parent.root == self
    end

    def parent_element
      parent.root? ? parent.parent : parent
    end
  end
end
