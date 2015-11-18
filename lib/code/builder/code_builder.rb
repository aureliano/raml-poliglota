module RamlPoliglota
  module Code
    module Builder

      class CodeBuilder

        include Support

        def initialize(language)
          @builder = case language
            when SUPPORTED_PROGRAMMING_LANGUAGES[:java] then Java::JavaBuilder.new
            else raise "Unsupported programming language #{language.name}."
          end
        end

        attr_reader :builder

        def build_model(hash)
          @builder.build_model hash
        end

      end

    end
  end
end