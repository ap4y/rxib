module RXib::Constraint
  module DSL
    def constraints
      element = children.find { |el| el.name == 'constraints' }
      return element if element

      element = Oga::XML::Element.new(name: 'constraints')
      children << element
      element
    end

    def assign_constraint(constraint)
      constraint_el = constraints.children.find do |el|
        el.constraint.replacement_for?(constraint)
      end

      constraint_el.remove if constraint_el
      constraints.children << Element.new(constraint)
    end

    def set(name, value)
      if (constraint_on = blueprint.constraints[name])
        RXib::Constraint.constraints_for(name, value, self).each do |c|
          constraint_root = constraint_on == :parent ? parent_element : self
          constraint_root.assign_constraint(c)
        end
      end

      super(name, value)
    end
  end
end
