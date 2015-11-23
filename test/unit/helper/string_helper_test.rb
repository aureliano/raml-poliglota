require 'test/unit'
require File.expand_path '../../../test_helper.rb', __FILE__
require File.expand_path '../../../../lib/helper/string_helper.rb', __FILE__

class StringHelperTest < Test::Unit::TestCase

  include RamlPoliglota::Helper::String
  
  def test_string_empty?
    assert_true(string_empty? nil)
    assert_true(string_empty? '')
    assert_true(string_empty? "")

    assert_false(string_empty? '123')
    assert_false(string_empty? 'abc')
  end

  def test_up_first_letter
    assert_equal 'Test', up_first_letter('test')
    assert_equal 'TestOne', up_first_letter('testOne')
    assert_equal 'TestOne', up_first_letter('TestOne')
  end

  def test_to_camel_case
    assert_equal 'ToCamelCase', to_camel_case('to_camel_case')
    assert_equal 'ToCamelCase', to_camel_case('ToCamelCase')
    assert_equal 'ToCamelCase', to_camel_case('_to_camel_case_')
    assert_equal 'Camel', to_camel_case('camel')
    assert_equal '', to_camel_case('')
  end

  def test_to_snake_case
    assert_equal 'to_camel_case', to_snake_case('ToCamelCase')
    assert_equal 'to_camel_case', to_snake_case('to_camel_case')
    assert_equal 'to_camel_case', to_snake_case('ToCamel_Case')
    assert_equal 'to_camel_case', to_snake_case('_ToCamel_case_')
    assert_equal 'camel', to_snake_case('Camel')
    assert_equal '', to_snake_case('')
  end
  
end