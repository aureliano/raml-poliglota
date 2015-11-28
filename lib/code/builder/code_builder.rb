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

        def build_imodel(namespace)
          raise 'Method not implemented.'
        end

        def build_icollection_model(namespace)
          raise 'Method not implemented.'
        end

        def build_model(hash)
          raise 'Method not implemented.'
        end

      end

    end
  end
end