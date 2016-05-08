module RXib
  @elements = {}

  def self.elements
    @elements
  end

  def self.define(name, &block)
    @elements[name] = block
  end

  def self.instantiate(name)
    element = Element.new(name: camelize(name))
    element.instance_eval(&@elements[name])
    element
  end

  def self.camelize(term)
    return term unless term =~ /_/
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
