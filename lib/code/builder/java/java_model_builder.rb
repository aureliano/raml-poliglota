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
            append_attributes clazz, text
            append_methods clazz, text

            text << "}"
          end

        end
      end
    end
  end
end