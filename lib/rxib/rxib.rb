module RXib
  @elements = {}

  def self.elements
    @elements
  end

  def self.define(name, extends: nil, &block)
    if extends
      parent = @elements[extends]
      @elements[name] = proc do
        instance_eval(&parent)
        instance_eval(&block)
      end
    else
      @elements[name] = block
    end
  end

  def self.instantiate(name)
    element = Element.new(name: camelize(name))
    element.instance_eval(&@elements[name])
    element
  end

  def self.camelize(term)
    return term.to_s unless term =~ /_/
    terms = term.to_s.split('_')
    terms[1..-1].each(&:capitalize!)
    terms.join
  end

  def self.generate_id
    id = SecureRandom.urlsafe_base64(6)
    id = SecureRandom.urlsafe_base64(6) until !/[-_]/.match(id)
    "#{id[0..2]}-#{id[3..4]}-#{id[5..8]}"
  end

  class Attribute < Oga::XML::Attribute; end
end
