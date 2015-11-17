module RamlPoliglota
  module Code
    module Builder

      class CodeBuilder

        include Support

        def self.create(language)
          case language.name
            when SUPPORTED_PROGRAMMING_LANGUAGES[:java].name then Java::JavaBuilder.new
            else raise "Unsupported programming language #{language.name}."
          end
        end

        def build_model(hash)
          raise "Method not implemented."
        end

      end

    end
  end
end