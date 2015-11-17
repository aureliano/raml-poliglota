require 'test/unit'
require 'json'
require File.expand_path '../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../lib/support/supported_programming_languages.rb', __FILE__
require File.expand_path '../../../../lib/parser/data_schema_parser.rb', __FILE__

class DataSchemaParserTest < Test::Unit::TestCase
  
  include RamlPoliglota::Support
  include RamlPoliglota::Parser

  def test_parse
    parser = DataSchemaParser.new
    assert_raise(RuntimeError) { parser.parse }

    parser.entity_name = 'BibleBean'
    assert_raise(RuntimeError) { parser.parse }

    parser.data_schema = '{}'
    assert_raise(RuntimeError) { parser.parse }

    parser.language = SUPPORTED_PROGRAMMING_LANGUAGES[:java]
    assert_nothing_raised(RuntimeError) { parser.parse }

    _test_java_parse
  end

  def _test_java_parse
    parser = DataSchemaParser.new do |p|
      p.namespace = 'com.github.aureliano.bean'
      p.entity_name = 'bible_bean'
      p.language = SUPPORTED_PROGRAMMING_LANGUAGES[:java]
      p.data_schema =  <<-FIN
{  "$schema": "http://json-schema.org/draft-03/schema",
   "type": "object",
   "description": "Holy bible.",
   "properties": {
     "bibleId": { "type": "integer", "required": true },
     "name": { "type": "string", "required": true },
     "language": { "type": "string", "required": true },
     "url": { "type": "string", "required": false },
     "edition": { "type": "string", "required": false },
     "copyright": { "type": "string", "required": false }
   }
}
FIN
    end

    hash = parser.parse
    assert_true hash.instance_of? Hash

    clazz = hash['class']
    assert_not_nil clazz

    assert_equal 'com.github.aureliano.bean', clazz.namespace
    assert_equal 'BibleBean', clazz.name
    assert_equal SUPPORTED_PROGRAMMING_LANGUAGES[:java], hash['language']

    assert_equal 'http://json-schema.org/draft-03/schema', hash['$schema']
    assert_equal 'object', hash['type']
    assert_equal 'Holy bible.', hash['description']
    assert_equal 6, clazz.attributes.size
  end
  
end