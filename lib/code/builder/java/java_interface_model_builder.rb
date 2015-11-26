module RamlPoliglota
  module Code
    module Builder
      module Java

        class JavaInterfaceModelBuilder

          include RamlPoliglota::Helper::JavaCodeBuilder

          def initialize
            @logger = AppLogger.create_logger self
          end

          def build(clazz)
            return if clazz.nil?

            @logger.debug "Write interface model class #{clazz.namespace}.#{clazz.name}"
            text = ''
            append_package clazz, text
            append_javadoc clazz, text
            _write_class_definition clazz, text

            text << "}"
          end

          private
          def _write_class_definition(clazz, target)
            definition = ((clazz.is_interface?) ? 'interface' : 'class')
            target << write_code("public #{definition} #{clazz.name} {", 0)
            target << "\n\n"
          end

        end
      end
    end
  end
end