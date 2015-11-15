require File.expand_path '../support/requires.rb', __FILE__

RamlPoliglota::Support::SourceLoader.new.load_project_source_files

include RamlPoliglota::Configuration

module RamlPoliglota

  class RamlPoliglota

    def initialize
      @logger = AppLogger.create_logger self
      yield self if block_given?
    end

    attr_accessor :execution

    def execute
      @logger.info "Initialize RAML client code generation."
      @logger.info "RAML file path: #{@execution.raml_path}"
      @logger.info "Target generation language: #{@execution.language}"
      @logger.info "Target output: #{@execution.output}"


      @logger.info "#{@execution.language} source-code generated to #{@execution.output}"
    end
  end
end