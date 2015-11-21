require File.expand_path '../code_generator.rb', __FILE__

module RamlPoliglota
  module Code
    module Generator

      class JavaGenerator < CodeGenerator

        include RamlPoliglota::Code::Builder
        include RamlPoliglota::Parser

        def initialize
          yield self if block_given?

          @logger = AppLogger.create_logger self
          @language = SUPPORTED_PROGRAMMING_LANGUAGES[:java]

          @builder = CodeBuilder.new @language
        end

        def generate(raml)
          return if raml.nil?
          @logger.info 'Generate Java code.'

          _generate_data_schemas raml.schemas
        end

        private
        def _generate_data_schemas(schemas)
          return if schemas.nil? || schemas.empty?
          @logger.info ' > Generate Java Beans.'

          model_dir = File.join @output_dir, 'model'
          unless File.exist? model_dir
            @logger.debug "Creating directory path #{model_dir}"
            FileUtils.mkdir_p model_dir
          end

          parser = DataSchemaParser.new do |p|
            p.namespace = @namespace
            p.language = @language
          end

          schemas.each do |key, value|
            @logger.debug " >> Generate data schema #{key}"
            parser.entity_name = key
            parser.data_schema = value

            hash = parser.parse
            content = @builder.build_model hash

            write_source_file('model', hash['class'].name, content)
          end
        end
      end
      
    end
  end
end