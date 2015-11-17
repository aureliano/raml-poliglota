require 'test/unit'
require File.expand_path '../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../lib/generator/code_generator.rb', __FILE__

class CodeGeneratorTest < Test::Unit::TestCase
  
  include RamlPoliglota::Generator

  def test_generate
    gen = CodeGenerator.new
    assert_raise(RuntimeError) { gen.generate(nil) }
  end

end