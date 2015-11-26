require 'test/unit'
require File.expand_path '../../../../lib/model/attribute_meta.rb', __FILE__

class AttributeMetaTest < Test::Unit::TestCase

  include RamlPoliglota::Model
  
  def test_initialization
    attribute = AttributeMeta.new
    assert_nil attribute.name
    assert_nil attribute.type
    assert_nil attribute.generic_type
    assert_nil attribute.visibility
    assert_nil attribute.static
    assert_nil attribute.final
    assert_nil attribute.init_value
    assert_nil attribute.default_value
    assert_nil attribute.relationship
    
    attribute.name = 'name'
    assert_equal 'name', attribute.name
    
    attribute.type = 'type'
    assert_equal 'type', attribute.type
    
    attribute.generic_type = 'generic_type'
    assert_equal 'generic_type', attribute.generic_type
    
    attribute.visibility = 'visibility'
    assert_equal 'visibility', attribute.visibility
    
    attribute.static = 'static'
    assert_equal 'static', attribute.static
    
    attribute.final = 'final'
    assert_equal 'final', attribute.final
    
    attribute.init_value = 'init_value'
    assert_equal 'init_value', attribute.init_value
    
    attribute.default_value = 'default_value'
    assert_equal 'default_value', attribute.default_value
    
    attribute.relationship = 'relationship'
    assert_equal 'relationship', attribute.relationship
  end

  def test_equal
    a1 = AttributeMeta.new do |a|
      a.name = 'test'
      a.type = 'int'
    end

    assert_not_equal a1, nil
    assert_not_equal a1, ''
    assert_not_equal a1, Array.new

    a2 = AttributeMeta.new
    a2.name = 'test'

    assert_equal a1, a2

    a2.name = 'field'
    assert_not_equal a1, a2
  end
  
end