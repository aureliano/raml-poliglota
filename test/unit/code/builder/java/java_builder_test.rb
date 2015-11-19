require 'test/unit'
require 'logging'
require File.expand_path '../../../../../test_helper.rb', __FILE__
require File.expand_path '../../../../../../lib/configuration/app_logger.rb', __FILE__
require File.expand_path '../../../../../../lib/code/builder/java/java_builder.rb', __FILE__

class JavaBuilderTest < Test::Unit::TestCase
  
  include RamlPoliglota::Code::Builder::Java

  def test_build_model
    builder = JavaBuilder.new
    
    clazz = CLASS_META_FACTORY[:model][:bilbo_baggins][:object]
    clazz.methods.clear
    hash = Hash.new
    hash['class'] = clazz

    expected = CLASS_META_FACTORY[:model][:bilbo_baggins][:text]
    actual = builder.build_model(hash)

    assert_equal expected, actual
  end

end