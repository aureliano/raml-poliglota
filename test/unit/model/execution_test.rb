require 'test/unit'
require File.expand_path '../../../../lib/model/execution.rb', __FILE__

class ExecutionTest < Test::Unit::TestCase

  include RamlPoliglota::Model
  
  def test_initialization
    exec = Execution.new
    assert_nil exec.language
    assert_nil exec.raml_path
    assert_nil exec.output
    assert_nil exec.namespace
    assert_nil exec.logger_level
    
    exec.language = 'Java'
    assert_equal 'Java', exec.language

    exec.raml_path = '/path/to/raml/model'
    assert_equal '/path/to/raml/model', exec.raml_path

    exec.output = '/path/to/output'
    assert_equal '/path/to/output', exec.output

    exec.namespace = 'br.mg.gv'
    assert_equal 'br.mg.gv', exec.namespace

    exec.logger_level = 'info'
    assert_equal 'info', exec.logger_level
  end
  
end