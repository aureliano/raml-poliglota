require 'test/unit'
require File.expand_path '../../../../test_helper.rb', __FILE__
require File.expand_path '../../../../../lib/support/supported_programming_languages.rb', __FILE__
require File.expand_path '../../../../../lib/code/builder/code_builder.rb', __FILE__
require File.expand_path '../../../../../lib/code/builder/java/java_builder.rb', __FILE__

class CodeBuilderTest < Test::Unit::TestCase
  
  include RamlPoliglota::Support
  include RamlPoliglota::Code::Builder
  include RamlPoliglota::Code::Builder::Java

  def test_create_code_builder
    assert_raise(ArgumentError) { CodeBuilder.create_code_builder }

    code_builder = CodeBuilder.create_code_builder SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    assert_true code_builder.instance_of? JavaBuilder
  end

  def test_build_imodel
    builder = CodeBuilder.create_code_builder SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    clazz = CLASS_META_FACTORY[:imodel][:object].dup

    expected = CLASS_META_FACTORY[:imodel][:text]
    actual = builder.build_imodel clazz.namespace

    assert_equal expected, actual
  end

  def test_build_icollection_model
    builder = CodeBuilder.create_code_builder SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    clazz = CLASS_META_FACTORY[:icollection_model][:object].dup

    expected = CLASS_META_FACTORY[:icollection_model][:text]
    actual = builder.build_icollection_model clazz.namespace

    assert_equal expected, actual
  end

  def test_build_model
    builder = CodeBuilder.create_code_builder SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    
    clazz = CLASS_META_FACTORY[:model][:bilbo_baggins][:object].dup
    clazz.methods.clear
    hash = Hash.new
    hash['class'] = clazz

    expected = CLASS_META_FACTORY[:model][:bilbo_baggins][:text]
    actual = builder.build_model(hash)

    assert_equal expected, actual
  end

  def test_build_iservice_parameters
    builder = CodeBuilder.create_code_builder SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    assert_raise(RuntimeError) { builder.build_iservice_parameters '' }
  end

end