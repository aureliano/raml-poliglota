module RamlPoliglota
  module Code
    module Builder
      module Java

        class JavaModelBuilder

          include RamlPoliglota::Helper::String
          include RamlPoliglota::Helper::JavaCodeBuilder

          def initialize
            @logger = AppLogger.create_logger self
          end

          def build(clazz)
            return if clazz.nil?

            @logger.debug "Write model class #{clazz.namespace}.#{clazz.name}"
            text = ''
            _write_namespace clazz, text
            _write_documentation clazz, text
            _write_class_definition clazz, text
            _write_attributes clazz, text
            _write_methods clazz, text

            text << "}"
          end

          private
          def _write_namespace(clazz, target)
            return if string_empty? clazz.namespace
            target << write_code("package #{clazz.namespace};\n\n", 0)
          end

          def _write_documentation(clazz, target)
            text = []
            text << "/**"
            text << " * Generated by RAML Poliglota."
            text << " *"
            text << " * #{clazz.documentation}"
            text << " */"

            target << write_code(text, 0)
            target << "\n"
          end

          def _write_class_definition(clazz, target)
            target << write_code("public class #{clazz.name} {", 0)
            target << "\n\n"
          end

          def _write_attributes(clazz, target)
            return if clazz.attributes.empty?
            target << clazz.attributes.collect do |attribute|
              "#{write_java_attribute(attribute)}"
            end.join("\n")
            target << "\n\n"
          end

          def _write_methods(clazz, target)
            return if clazz.methods.empty?
            target << clazz.methods.collect do |method|
              write_java_method(method)
            end.join("\n\n")
            target << "\n"
          end

        end
      end
    end
  end
end