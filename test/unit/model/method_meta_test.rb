require 'test/unit'
require File.expand_path '../../../../lib/model/method_meta.rb', __FILE__

class MethodMetaTest < Test::Unit::TestCase

  include RamlPoliglota::Model
  
  def test_initialization
    attribute = MethodMeta.new
    assert_nil attribute.name
    assert_nil attribute.return_type
    assert_nil attribute.generic_return_type
    assert_nil attribute.visibility
    assert_nil attribute.static
    assert_nil attribute.final
    assert_nil attribute.parameters
    assert_nil attribute.body
    
    attribute.name = 'name'
    assert_equal 'name', attribute.name
    
    attribute.return_type = 'return_type'
    assert_equal 'return_type', attribute.return_type
    
    attribute.generic_return_type = 'generic_return_type'
    assert_equal 'generic_return_type', attribute.generic_return_type
    
    attribute.visibility = 'visibility'
    assert_equal 'visibility', attribute.visibility
    
    attribute.static = 'static'
    assert_equal 'static', attribute.static
    
    attribute.final = 'final'
    assert_equal 'final', attribute.final
    
    attribute.parameters = [AttributeMeta.new { |a| a.name = 'test' }]
    assert_equal [AttributeMeta.new { |a| a.name = 'test' }], attribute.parameters
    
    attribute.body = 'body'
    assert_equal 'body', attribute.body
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
  
end