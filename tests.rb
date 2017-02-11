require 'test/unit'
require './interface.rb'

class InterfaceTest < Test::Unit::TestCase
	def setup
		@interface = Interface.new(Hash.new)
  end

  def test_that_asana_token_is_nil_on_initialize
    assert_nil @interface.asana_personal_token
  end

end

