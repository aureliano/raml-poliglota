require 'test/unit'
require File.expand_path '../../../../lib/model/class_meta.rb', __FILE__

class ClassMetaTest < Test::Unit::TestCase

  include RamlPoliglota::Model
  
  def test_initialization
    clazz = ClassMeta.new
    assert_nil clazz.name
    assert_nil clazz.namespace
    assert_nil clazz.documentation
    assert_nil clazz.attributes
    assert_nil clazz.methods
    assert_nil clazz.interfaces
    
    clazz.name = 'name'
    assert_equal 'name', clazz.name
    
    clazz.namespace = 'namespace'
    assert_equal 'namespace', clazz.namespace
    
    clazz.documentation = 'documentation'
    assert_equal 'documentation', clazz.documentation
    
    clazz.attributes = [AttributeMeta.new]
    assert_equal [AttributeMeta.new], clazz.attributes
    
    clazz.methods = [MethodMeta.new]
    assert_equal [MethodMeta.new], clazz.methods

    clazz.interfaces = [ClassMeta.new]
    assert_equal [ClassMeta.new], clazz.interfaces
  end

  def test_equal
    a1 = ClassMeta.new do |a|
      a.name = 'test'
      a.namespace = 'int'
    end

    assert_not_equal a1, nil
    assert_not_equal a1, ''
    assert_not_equal a1, Array.new

    a2 = ClassMeta.new
    a2.name = 'test'

    assert_equal a1, a2

    a2.name = 'field'
    assert_not_equal a1, a2
  end
  
end