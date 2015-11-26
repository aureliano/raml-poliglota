require 'test/unit'
require File.expand_path '../../../../lib/model/method_meta.rb', __FILE__

class MethodMetaTest < Test::Unit::TestCase

  include RamlPoliglota::Model
  
  def test_initialization
    method = MethodMeta.new
    assert_nil method.name
    assert_nil method.return_type
    assert_nil method.generic_return_type
    assert_nil method.visibility
    assert_nil method.static
    assert_nil method.final
    assert_nil method.parameters
    assert_nil method.body
    assert_nil method.abstract
    
    method.name = 'name'
    assert_equal 'name', method.name
    
    method.return_type = 'return_type'
    assert_equal 'return_type', method.return_type
    
    method.generic_return_type = 'generic_return_type'
    assert_equal 'generic_return_type', method.generic_return_type
    
    method.visibility = 'visibility'
    assert_equal 'visibility', method.visibility
    
    method.static = 'static'
    assert_equal 'static', method.static
    
    method.final = 'final'
    assert_equal 'final', method.final
    
    method.parameters = [AttributeMeta.new { |a| a.name = 'test' }]
    assert_equal [AttributeMeta.new { |a| a.name = 'test' }], method.parameters
    
    method.body = 'body'
    assert_equal 'body', method.body
    
    method.abstract = true
    assert_true method.abstract
  end

  def test_equal
    m1 = MethodMeta.new do |m|
      m.name = 'make'
      m.parameters = [AttributeMeta.new { |a| a.name = 'param' }]
    end

    assert_not_equal m1, nil
    assert_not_equal m1, ''
    assert_not_equal m1, Array.new
    assert_not_equal m1, AttributeMeta.new

    m2 = MethodMeta.new
    m2.name = 'make'

    assert_not_equal m1, m2

    m2.parameters = [AttributeMeta.new { |a| a.name = 'wrong' }]
    assert_not_equal m1, m2

    m2.parameters = [AttributeMeta.new { |a| a.name = 'param' }]
    assert_equal m1, m2

    m2.name = 'field'
    assert_not_equal m1, m2
  end

  def test_has_parameters?
    method = MethodMeta.new
    assert_false method.has_parameters?

    method.parameters = [AttributeMeta.new { |a| a.name = 'param' }]
    assert_true method.has_parameters?
  end

  def test_add_parameter
    m = MethodMeta.new

    m.add_parameter(AttributeMeta.new { |a| a.name = 'field_1' })
    assert_equal 1, m.parameters.size
    assert_equal 'field_1', m.parameters[0].name

    m.add_parameter(AttributeMeta.new { |a| a.name = 'field_2' })
    assert_equal 2, m.parameters.size
    assert_equal 'field_2', m.parameters[1].name
  end

  def test_is_abstract?
    m = MethodMeta.new

    assert_false m.is_abstract?

    m.abstract = false
    assert_false m.is_abstract?
    
    m.abstract = true
    assert_true m.is_abstract?
  end
  
end