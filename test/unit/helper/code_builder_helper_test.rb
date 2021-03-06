require 'test/unit'
require File.expand_path '../../../test_helper.rb', __FILE__
require File.expand_path '../../../../lib/model/attribute_meta.rb', __FILE__
require File.expand_path '../../../../lib/model/method_meta.rb', __FILE__
require File.expand_path '../../../../lib/helper/string_helper.rb', __FILE__
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

end