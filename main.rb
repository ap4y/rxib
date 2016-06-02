require 'pry'
require './lib/rxib'

handler = RXib::SaxHandler.new
parser  = Oga::XML::SaxParser.new(handler, File.open('test.xml'), html: true)
parser.parse

File.open('test.xib', 'w') do |f|
  formatter = RXib::Formatter.new(handler.document)
  formatter.format
  f.write(formatter.output)
end
