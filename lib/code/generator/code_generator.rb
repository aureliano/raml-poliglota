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

        def write_source_file(sub_dir, entity_name, content)
          dir = File.join @output_dir, sub_dir
          unless File.exist? dir
            @logger.debug "Creating directory path #{dir}"
            FileUtils.mkdir_p dir
          end

          file_path = File.join @output_dir, sub_dir, "#{entity_name}.#{@language.name.downcase}"
          @logger.debug "Creating model file #{file_path}"
          File.open(file_path, 'w') { |file| file.write content }
        end

      end

    end
  end
end