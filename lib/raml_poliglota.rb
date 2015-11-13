require File.expand_path '../support/requires.rb', __FILE__

RamlPoliglota::Support::SourceLoader.new.load_project_source_files

module RamlPoliglota

  class RamlPoliglota

    def initialize
      yield self if block_given?
    end

    attr_accessor :execution
    
  end
end