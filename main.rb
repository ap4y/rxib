require 'pry'
require './lib/rxib'

handler = RXib::SaxHandler.new
parser  = Oga::XML::SaxParser.new(handler, File.open('test.xml'), html: true)
parser.parse

File.open('test.xib', 'w') { |f| f.write(handler.document.to_xml) }
