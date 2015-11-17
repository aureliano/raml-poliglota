require 'test/unit'
require 'logging'
require File.expand_path '../../../assert_helper.rb', __FILE__
require File.expand_path '../../../../lib/configuration/app_logger.rb', __FILE__
require File.expand_path '../../../../lib/generator/java_generator.rb', __FILE__

class JavaGeneratorTest < Test::Unit::TestCase
  
  include RamlPoliglota::Generator

  def test_generate
    gen = JavaGenerator.new
    gen.namespace = 'br.mg.gv'
    assert_nothing_raised(RuntimeError) { gen.generate(nil) }
  end

end