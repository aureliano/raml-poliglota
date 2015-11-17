module RamlPoliglota
  module Gen

    class JavaGen < CodeGen

      def initialize
        @logger = AppLogger.create_logger self
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

        parser = DataSchemaParser.new do |p|
          p.namespace = @namespace
          p.language = SUPPORTED_PROGRAMMING_LANGUAGES[:java]
        end

        schemas.each do |key, value|
          parser.entity_name = key
          parser.data_schema = value

          hash = parser.parse
          #builder.build hash
        end
      end

    end

  end
end