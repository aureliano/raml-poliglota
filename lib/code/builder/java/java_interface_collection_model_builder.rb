module RamlPoliglota
  module Code
    module Builder
      module Java

        class JavaInterfaceCollectionModelBuilder

          include RamlPoliglota::Helper::JavaCodeBuilder

          def initialize
            @logger = AppLogger.create_logger self
          end

          def build(namespace)
            clazz = ClassMeta.new do |c|
              c.namespace = namespace
              c.is_interface = true
              c.name = 'ICollectionModel'
              c.documentation = 'Define a type to API data schema collection models.'
              c.generics = 'T extends IModel'

              c.add_method(MethodMeta.new do |m|
                m.visibility = 'public'
                m.name = 'getElements'
                m.return_type = 'array'
                m.generic_return_type = 'T'
                m.abstract = true
              end)

              c.add_method(MethodMeta.new do |m|
                m.visibility = 'public'
                m.name = 'getSize'
                m.return_type = 'Integer'
                m.abstract = true
              end)
            end

            _build_class clazz
          end

          private
          def _build_class(clazz)
            @logger.debug "Write interface collection model class #{clazz.namespace}.#{clazz.name}"
            text = ''
            append_package clazz, text
            append_javadoc clazz, text
            append_class_definition clazz, text
            append_methods clazz, text

            text << "}"
          end

        end
      end
    end
  end
end