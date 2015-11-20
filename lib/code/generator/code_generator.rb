module RamlPoliglota
  module Code
    module Generator

      class CodeGenerator

        include Support

        attr_accessor :namespace, :output_dir

        def self.create(language)
          case language.name
            when SUPPORTED_PROGRAMMING_LANGUAGES[:java].name then JavaGenerator.new
            else raise "Unsupported programming language #{language.name}."
          end
        end

        def generate(raml)
          raise "Method not implemented."
        end

      end

    end
  end
end