module RamlPoliglota
  module Validation
    
    class InputValidation

      include RamlPoliglota::Helper

      def self.validate_inputs(execution)
        message = _validate_raml_path execution.raml_path
        return message unless message.nil?

        message = _validate_language execution.language
        return message unless message.nil?

        message = _validate_output execution.output
        return message
      end

      private
      def self._validate_raml_path(raml_path)
        return "RAML source path must not be empty." if StringHelper.empty? raml_path
        return "RAML file path #{raml_path} does not exist." unless File.exist? raml_path
      end

      def self._validate_language(language)
        return "Programming Language must not be empty." if StringHelper.empty? language
        include RamlPoliglota::Support

        found = SUPPORTED_PROGRAMMING_LANGUAGES.select { |supported| supported.downcase == language.downcase }
        return "#{language} is not a supported programming language." if found.empty?
      end

      def self._validate_output(output)
        return "Target output must not be empty." if StringHelper.empty? output
      end

    end

  end
end