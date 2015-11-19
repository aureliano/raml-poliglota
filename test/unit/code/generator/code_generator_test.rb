require 'test/unit'
require File.expand_path '../../../../test_helper.rb', __FILE__
require File.expand_path '../../../../../lib/support/supported_programming_languages.rb', __FILE__
require File.expand_path '../../../../../lib/code/generator/code_generator.rb', __FILE__

class CodeGeneratorTest < Test::Unit::TestCase
  
  include RamlPoliglota::Support
  include RamlPoliglota::Code::Generator

  def test_create
    gen = CodeGenerator.create SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    assert_true gen.instance_of? JavaGenerator
  end

  def test_generate
    gen = CodeGenerator.new
    assert_raise(RuntimeError) { gen.generate(nil) }
  end

end