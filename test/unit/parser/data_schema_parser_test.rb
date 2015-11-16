require 'test/unit'
require File.expand_path '../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../lib/parser/data_schema_parser.rb', __FILE__

class DataSchemaParserTest < Test::Unit::TestCase
  
  include RamlPoliglota::Parser

  def test_parse
    assert_raise RuntimeError do
      DataSchemaParser.new.parse
    end
  end
  
end