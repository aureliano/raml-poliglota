require 'test/unit'
require File.expand_path '../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../lib/helper/string_helper.rb', __FILE__

class StringHelperTest < Test::Unit::TestCase

  include RamlPoliglota::Helper
  
  def test_empty?
    assert_true(StringHelper.empty? nil)
    assert_true(StringHelper.empty? '')
    assert_true(StringHelper.empty? "")

    assert_false(StringHelper.empty? '123')
    assert_false(StringHelper.empty? 'abc')
  end

  def test_to_camel_case
    assert_equal 'ToCamelCase', StringHelper.to_camel_case('to_camel_case')
    assert_equal 'Camel', StringHelper.to_camel_case('camel')
    assert_equal '', StringHelper.to_camel_case('')
  end
  
end