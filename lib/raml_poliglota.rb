require File.expand_path '../support/requires.rb', __FILE__

RamlPoliglota::Support::SourceLoader.new.load_project_source_files

include RamlPoliglota::Configuration
include RamlPoliglota::Validation

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

      _apply_validations
      raml = _parse_raml

      @logger.info "#{@execution.language} source-code generated to #{@execution.output}"
    end

    private
    def _apply_validations
      message = InputValidation.validate_inputs @execution
      unless message.nil?
        puts
        @logger.error message
        exit 100
      end
    end

    def _parse_raml
      begin
        RamlParser::Parser.parse_file(@execution.raml_path)
      rescue Exception => ex
        puts
        @logger.error ex.message
        exit 101
      end
    end

  end
end