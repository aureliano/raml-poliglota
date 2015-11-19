require 'test/unit'
require File.expand_path '../../../test_helper.rb', __FILE__
require File.expand_path '../../../../lib/model/programming_language.rb', __FILE__

class ProgrammingLanguageTest < Test::Unit::TestCase
  
  include RamlPoliglota::Model

  def test_equal
    p1 = ProgrammingLanguage.new do |p|
      p.name = 'Java'
      p.case = 'camel'
    end

    assert_not_equal p1, nil
    assert_not_equal p1, ''
    assert_not_equal p1, Array.new

    p2 = ProgrammingLanguage.new
    p2.name = 'Java'

    assert_equal p1, p2

    p2.name = 'Ruby'
    assert_not_equal p1, p2
  end
  
end