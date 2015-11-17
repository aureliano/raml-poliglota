module RamlPoliglota
  module Gen

    class CodeGen

      include RamlPoliglota::Support

      attr_accessor :namespace

      def self.create(language)
        case language.name
          when SUPPORTED_PROGRAMMING_LANGUAGES[:java].name then JavaGen.new
          else raise "Unsupported programming language #{language.name}."
        end
      end

      def generate(raml)
        raise "Method not implemented."
      end

    end

  end
end