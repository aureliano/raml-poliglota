require 'test/unit'
require File.expand_path '../../../lib/raml_poliglota.rb', __FILE__
require File.expand_path '../../../lib/model/execution.rb', __FILE__

class RamlPoliglotaTest < Test::Unit::TestCase

  include RamlPoliglota
  include Model

  def test_load
    e = Execution.new
    e.raml_path = File.expand_path 'test/resource/verbum-domini.raml'
    e.output = 'tmp/generated-raml-sources'
    e.language = 'java'
    e.namespace = 'br.mg.gv'

    api = RamlPoliglota.new { |rp| rp.execution = e }
    api.execute
  end

end