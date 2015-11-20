require File.expand_path '../support/requires.rb', __FILE__

RamlPoliglota::Support::SourceLoader.new.load_project_source_files

include RamlPoliglota::Configuration
include RamlPoliglota::Support
include RamlPoliglota::Validation
include RamlPoliglota::Code::Generator

module RamlPoliglota

  class RamlPoliglota

    def initialize
      yield self if block_given?

      AppLogger.set_default_level @execution.logger_level
      @logger = AppLogger.create_logger self
    end

    attr_accessor :execution

    def execute
      @logger.info "Initialize RAML client code generation."
      @logger.info "RAML file path: #{@execution.raml_path}"

      _apply_validations
      raml = _parse_raml

      _generate_code raml

      @logger.info "#{@execution.language} source-code generated to #{@execution.output}"
    end

    private
    def _apply_validations
      message = InputValidation.new.validate_inputs @execution
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

    def _create_code_generator
      language = SUPPORTED_PROGRAMMING_LANGUAGES[@execution.language.to_s.downcase.to_sym]
      CodeGenerator.create language
    end

    def _generate_code(raml)
      generator = _create_code_generator
      generator.namespace = @execution.namespace
      generator.output_dir = @execution.output
      generator.generate raml
    end

  end
end