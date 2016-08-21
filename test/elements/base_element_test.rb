require_relative '../test_helper'
require_relative 'common'

class BaseElementTest < Minitest::Test
  include BehavesAsBaseElement

  def setup
    @el = RXib::Elements::Base.new
    @el.synthesize
  end
end
