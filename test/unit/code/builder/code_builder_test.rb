require 'test/unit'
require File.expand_path '../../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../../lib/support/supported_programming_languages.rb', __FILE__
require File.expand_path '../../../../../lib/code/builder/code_builder.rb', __FILE__

class CodeBuilderTest < Test::Unit::TestCase
  
  include RamlPoliglota::Support
  include RamlPoliglota::Code::Builder

  def test_create
    builder = CodeBuilder.create SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    assert_true builder.instance_of? JavaBuilder
  end

  def test_build
    builder = CodeBuilder.new
    assert_raise(RuntimeError) { builder.generate(nil) }
  end

end