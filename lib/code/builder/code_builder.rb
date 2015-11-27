module RamlPoliglota
  module Code
    module Builder

      class CodeBuilder

        include Support

        def self.create_code_builder(language)
          case language
            when SUPPORTED_PROGRAMMING_LANGUAGES[:java] then Java::JavaBuilder.new
            else raise "Unsupported programming language #{language.name}."
          end
        end

        attr_reader :builder

        def build_imodel(namespace)
          @builder.build_imodel namespace
        end

        def build_icollection_model(namespace)
          @builder.build_icollection_model namespace
        end

        def build_model(hash)
          @builder.build_model hash
        end

      end

    end
  end
end