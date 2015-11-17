module RamlPoliglota
  module Generator

    class CodeGenerator

      include RamlPoliglota::Support

      attr_accessor :namespace

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