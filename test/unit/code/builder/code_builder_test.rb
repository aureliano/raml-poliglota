require 'test/unit'
require File.expand_path '../../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../../lib/support/supported_programming_languages.rb', __FILE__
require File.expand_path '../../../../../lib/code/builder/code_builder.rb', __FILE__
require File.expand_path '../../../../../lib/code/builder/java/java_builder.rb', __FILE__

class CodeBuilderTest < Test::Unit::TestCase
  
  include RamlPoliglota::Support
  include RamlPoliglota::Code::Builder
  include RamlPoliglota::Code::Builder::Java

  def test_initialization
    assert_raise(ArgumentError) { CodeBuilder.new }

    code_builder = CodeBuilder.new SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    assert_true code_builder.builder.instance_of? JavaBuilder
  end

  def test_build_model
    builder = CodeBuilder.new SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    
    clazz = CLASS_META_FACTORY[:model][:bilbo_baggins][:object]
    clazz.methods.clear
    hash = Hash.new
    hash['class'] = clazz

    expected = CLASS_META_FACTORY[:model][:bilbo_baggins][:text]
    actual = builder.build_model(hash)

    assert_equal expected, actual
  end

end