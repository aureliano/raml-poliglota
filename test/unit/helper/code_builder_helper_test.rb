require 'test/unit'
require File.expand_path '../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../lib/model/attribute_meta.rb', __FILE__
require File.expand_path '../../../../lib/model/method_meta.rb', __FILE__
require File.expand_path '../../../../lib/helper/code_builder_helper.rb', __FILE__

class CodeBuilderHelperTest < Test::Unit::TestCase

  include RamlPoliglota::Helper::CodeBuilder
  include RamlPoliglota::Model

  def test_write_tabulation
    assert_equal '', write_tabulation(0)
    assert_equal '  ', write_tabulation(1)
    assert_equal '    ', write_tabulation(2)
  end

  def test_write_string
    assert_equal 'test', write_string('test', 0)
    assert_equal '  test', write_string('test', 1)
  end

  def test_write_array
    assert_equal 'test', write_array(['test'], 0)
    assert_equal "  test\n  done", write_array(['test', 'done'], 1)
  end

  def test_write_code
    assert_equal '  test', write_code('test', 1)
    assert_equal "  test\n  done", write_code(['test', 'done'], 1)
  end

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

end