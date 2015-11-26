require 'test/unit'
require 'logging'
require File.expand_path '../../../../../test_helper.rb', __FILE__
require File.expand_path '../../../../../../lib/configuration/app_logger.rb', __FILE__
require File.expand_path '../../../../../../lib/model/class_meta.rb', __FILE__
require File.expand_path '../../../../../../lib/code/builder/java/java_model_builder.rb', __FILE__

class JavaInterfaceModelBuilderTest < Test::Unit::TestCase
  
  include RamlPoliglota::Code::Builder::Java
  include RamlPoliglota::Model

  def test_build
    builder = JavaInterfaceModelBuilder.new
    clazz = CLASS_META_FACTORY[:imodel][:object]

    expected = CLASS_META_FACTORY[:imodel][:text]
    actual = builder.build clazz

    assert_equal expected, actual
  end

end