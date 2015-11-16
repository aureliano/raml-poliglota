module RamlPoliglota
  module Helper
    
    class InputValidation

      def self.validate_inputs(execution)
        message = _validate_raml_path execution.raml_path
        return unless message.nil?

        message = _validate_language execution.language
        return unless message.nil?

        message = _validate_output execution.output
        return message
      end

      private
      def _validate_raml_path(raml_path)
        return "RAML source path must not be empty." if StringHelper.empty? raml_path
        return "RAML file path #{raml_path} does not exist." if File.exist? raml_path
      end

      def _validate_language(language)
        return "Programming Language must not be empty." if StringHelper.empty? language
        return "#{language} is not a supported programming language." unless SUPPORTED_PROGRAMMING_LANGUAGES.include? language
      end

      def _validate_output(output)
        return "Target output must not be empty." if StringHelper.empty? output
      end

    end

  end
end