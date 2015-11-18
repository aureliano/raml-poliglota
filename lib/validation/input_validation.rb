module RamlPoliglota
  module Validation
    
    class InputValidation

      include RamlPoliglota::Helper::String
      include RamlPoliglota::Support

      def validate_inputs(execution)
        message = _validate_raml_path execution.raml_path
        return message unless message.nil?

        message = _validate_language execution.language
        return message unless message.nil?

        message = _validate_output execution.output
        return message
      end

      private
      def _validate_raml_path(raml_path)
        return "RAML source path must not be empty." if string_empty? raml_path
        return "RAML file path #{raml_path} does not exist." unless File.exist? raml_path
      end

      def _validate_language(language)
        return "Programming Language must not be empty." if string_empty? language

        found = SUPPORTED_PROGRAMMING_LANGUAGES.select do |supported|
          SUPPORTED_PROGRAMMING_LANGUAGES[supported].name.downcase == language.downcase
        end
        return "#{language} is not a supported programming language." if found.empty?
      end

      def _validate_output(output)
        return "Target output must not be empty." if string_empty? output
      end

    end

  end
end