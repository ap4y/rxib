module RXib
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
end
