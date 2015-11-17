require 'test/unit'
require 'logging'
require File.expand_path '../../../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../../../lib/configuration/app_logger.rb', __FILE__
require File.expand_path '../../../../../../lib/code/builder/java/java_builder.rb', __FILE__

class JavaBuilderTest < Test::Unit::TestCase
  
  include RamlPoliglota::Code::Builder::Java

  def test_build_model
    builder = JavaBuilder.new
    assert_nothing_raised(RuntimeError) { builder.build_model(nil) }
  end

end