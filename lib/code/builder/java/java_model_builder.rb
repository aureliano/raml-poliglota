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
            append_package clazz, text
            append_javadoc clazz, text
            append_class_definition clazz, text
            _write_attributes clazz, text
            _write_methods clazz, text

            text << "}"
          end

          private
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