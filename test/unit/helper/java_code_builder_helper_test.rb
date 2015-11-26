require 'test/unit'
require File.expand_path '../../../test_helper.rb', __FILE__
require File.expand_path '../../../../lib/model/attribute_meta.rb', __FILE__
require File.expand_path '../../../../lib/model/method_meta.rb', __FILE__
require File.expand_path '../../../../lib/model/class_meta.rb', __FILE__
require File.expand_path '../../../../lib/helper/string_helper.rb', __FILE__
require File.expand_path '../../../../lib/helper/code_builder_helper.rb', __FILE__
require File.expand_path '../../../../lib/helper/java_code_builder_helper.rb', __FILE__

class JavaCodeBuilderHelperTest < Test::Unit::TestCase

  include RamlPoliglota::Helper::JavaCodeBuilder
  include RamlPoliglota::Model

  def test_write_java_attribute
    text = write_java_attribute(AttributeMeta.new do |a|
      a.visibility = 'private'
      a.type = 'Integer'
      a.name = 'id'
    end)

    assert_equal '  private Integer id;', text

    text = write_java_attribute(AttributeMeta.new do |a|
      a.visibility = 'protected'
      a.type = 'String'
      a.name = 'name'
    end)

    assert_equal '  protected String name;', text
  end

  def test_write_java_method
    text = write_java_method(MethodMeta.new do |m|
      m.visibility = 'protected'
      m.return_type = 'Integer'
      m.name = 'getId'
      m.body = 'return this.id;'
    end)

    assert_equal "  protected Integer getId() {\n    return this.id;\n  }", text

    text = write_java_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'void'
      m.name = 'setId'
      m.add_parameter(AttributeMeta.new do |a|
        a.type = 'Integer'
        a.name = 'id'
      end)
      m.body = 'this.id = id;'
    end)

    assert_equal "  public void setId(Integer id) {\n    this.id = id;\n  }", text
  end

  def test_js_to_java_type
    assert_raise(RuntimeError) { js_to_java_type nil }
    assert_raise(RuntimeError) { js_to_java_type '' }

    assert_equal 'String', js_to_java_type('string')
    assert_equal 'Double', js_to_java_type('number')
    assert_equal 'Integer', js_to_java_type('integer')
    assert_equal 'Boolean', js_to_java_type('boolean')
    assert_equal 'Object', js_to_java_type('value')
    assert_equal 'java.util.List', js_to_java_type('array')
    assert_equal 'Object', js_to_java_type('object')
    assert_equal 'FrodoBaggins', js_to_java_type('frodoBaggins')
  end

  def test_append_package
    clazz = CLASS_META_FACTORY[:model][:bilbo_baggins][:object]
    target = ''

    append_package(clazz, target)
    assert_equal "package br.mg.gv;\n\n", target
  end

end