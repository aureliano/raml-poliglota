require 'test/unit'
require File.expand_path '../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../lib/support/supported_programming_languages.rb', __FILE__
require File.expand_path '../../../../lib/generator/code_gen.rb', __FILE__

class CodeGenTest < Test::Unit::TestCase
  
  include RamlPoliglota::Support
  include RamlPoliglota::Gen

  def test_create
    gen = CodeGen.create SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    assert_true gen.instance_of? JavaGen
  end

  def test_generate
    gen = CodeGen.new
    assert_raise(RuntimeError) { gen.generate(nil) }
  end

end