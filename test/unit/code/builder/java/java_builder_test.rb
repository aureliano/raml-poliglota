require 'test/unit'
require 'logging'
require File.expand_path '../../../../../test_helper.rb', __FILE__
require File.expand_path '../../../../../../lib/configuration/app_logger.rb', __FILE__
require File.expand_path '../../../../../../lib/code/builder/java/java_builder.rb', __FILE__

class JavaBuilderTest < Test::Unit::TestCase
  
  include RamlPoliglota::Code::Builder::Java

  def test_build_model
    builder = JavaBuilder.new
    
    clazz = CLASS_META_FACTORY[:model][:bilbo_baggins][:object].dup
    clazz.methods.clear
    hash = Hash.new
    hash['class'] = clazz

    expected = CLASS_META_FACTORY[:model][:bilbo_baggins][:text]
    actual = builder.build_model(hash)

    assert_equal expected, actual
  end

  def test_build_imodel
    builder = JavaBuilder.new
    clazz = CLASS_META_FACTORY[:imodel][:object].dup

    expected = CLASS_META_FACTORY[:imodel][:text]
    actual = builder.build_imodel clazz.namespace

    assert_equal expected, actual
  end

  def test_build_icollection_model
    builder = JavaBuilder.new
    clazz = CLASS_META_FACTORY[:icollection_model][:object].dup

    expected = CLASS_META_FACTORY[:icollection_model][:text]
    actual = builder.build_icollection_model clazz.namespace

    assert_equal expected, actual
  end

  def test_build_iservice_parameters
    builder = JavaBuilder.new
    assert_raise(RuntimeError) { builder.build_iservice_parameters '' }
  end

end