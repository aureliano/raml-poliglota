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
    assert_nil attribute.static_field
    assert_nil attribute.final_field
    assert_nil attribute.init_vaule
    assert_nil attribute.default_value
    
    attribute.name = 'name'
    assert_equal 'name', attribute.name
    
    attribute.type = 'type'
    assert_equal 'type', attribute.type
    
    attribute.generic_type = 'generic_type'
    assert_equal 'generic_type', attribute.generic_type
    
    attribute.visibility = 'visibility'
    assert_equal 'visibility', attribute.visibility
    
    attribute.static_field = 'static_field'
    assert_equal 'static_field', attribute.static_field
    
    attribute.final_field = 'final_field'
    assert_equal 'final_field', attribute.final_field
    
    attribute.init_vaule = 'init_vaule'
    assert_equal 'init_vaule', attribute.init_vaule
    
    attribute.default_value = 'default_value'
    assert_equal 'default_value', attribute.default_value
  end
  
end