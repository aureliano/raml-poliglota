module RamlPoliglota
  module Code
    module Builder
      module Java

        class JavaInterfaceModelBuilder

          include RamlPoliglota::Helper::JavaCodeBuilder

          def initialize
            @logger = AppLogger.create_logger self
          end

          def build(namespace)
            clazz = ClassMeta.new do |c|
              c.namespace = namespace
              c.is_interface = true
              c.name = 'IModel'
              c.documentation = 'Define a type to API data schema models.'
            end

            _build_class clazz
          end

          private
          def _build_class(clazz)
            @logger.debug "Write interface model class #{clazz.namespace}.#{clazz.name}"
            text = ''
            append_package clazz, text
            append_javadoc clazz, text
            append_class_definition clazz, text

            text << "}"
          end

        end
      end
    end
  end
end