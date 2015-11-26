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
    assert_nil clazz.is_interface
    assert_nil clazz.generics
    
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
    
    clazz.is_interface = true
    assert_true clazz.is_interface
    
    clazz.generics = 'generics'
    assert_equal 'generics', clazz.generics
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

  def test_add_attribute
    c = ClassMeta.new

    c.add_attribute(AttributeMeta.new { |a| a.name = 'field_1' })
    assert_equal 1, c.attributes.size
    assert_equal 'field_1', c.attributes[0].name

    c.add_attribute(AttributeMeta.new { |a| a.name = 'field_2' })
    assert_equal 2, c.attributes.size
    assert_equal 'field_2', c.attributes[1].name
  end

  def test_add_method
    c = ClassMeta.new

    c.add_method(MethodMeta.new { |m| m.name = 'method_1' })
    assert_equal 1, c.methods.size
    assert_equal 'method_1', c.methods[0].name

    c.add_method(MethodMeta.new { |m| m.name = 'method_2' })
    assert_equal 2, c.methods.size
    assert_equal 'method_2', c.methods[1].name
  end

  def test_is_interface?
    c = ClassMeta.new

    assert_false c.is_interface?

    c.is_interface = false
    assert_false c.is_interface?
    
    c.is_interface = true
    assert_true c.is_interface?
  end
  
end