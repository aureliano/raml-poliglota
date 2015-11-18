require 'test/unit'
require File.expand_path '../../../../lib/model/execution.rb', __FILE__
require File.expand_path '../../../../lib/model/programming_language.rb', __FILE__
require File.expand_path '../../../../lib/support/supported_programming_languages.rb', __FILE__
require File.expand_path '../../../../lib/validation/input_validation.rb', __FILE__

class InputValidationTest < Test::Unit::TestCase

  include RamlPoliglota::Support
  include RamlPoliglota::Model
  include RamlPoliglota::Validation
  
  def test_validate_inputs
    input_validation = InputValidation.new
  	execution = Execution.new
    
  	execution.language = 'Ruby'
  	execution.output = 'test'

  	assert_equal("RAML source path must not be empty.", input_validation.validate_inputs(execution))
  	execution.raml_path = '/tmp/test'
  	assert_equal("RAML file path #{execution.raml_path} does not exist.", input_validation.validate_inputs(execution))

  	execution.raml_path = File.expand_path('../../../../Gemfile', __FILE__)
  	execution.language = nil

  	assert_equal("Programming Language must not be empty.", input_validation.validate_inputs(execution))
  	execution.language = 'Python'
  	assert_equal("#{execution.language} is not a supported programming language.", input_validation.validate_inputs(execution))

  	execution.language = 'Java'
  	execution.output = nil

  	assert_equal("Target output must not be empty.", input_validation.validate_inputs(execution))
  end
  
end