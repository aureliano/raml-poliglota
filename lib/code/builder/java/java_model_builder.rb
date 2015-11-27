module RamlPoliglota
  module Code
    module Builder
      module Java

        class JavaModelBuilder

          include RamlPoliglota::Helper::Text
          include RamlPoliglota::Helper::JavaCodeBuilder

          def initialize
            @logger = AppLogger.create_logger self
          end

          def build(hash)
            return if hash.nil?

            clazz = hash['class']
            
            _configure_class_object clazz
            _build_class clazz
          end

          private
          def _build_class(clazz)
            @logger.debug "Write model class #{clazz.namespace}.#{clazz.name}"
            text = ''
            append_package clazz, text
            append_javadoc clazz, text
            append_class_definition clazz, text
            append_attributes clazz, text
            append_methods clazz, text

            text << "}"
          end

          def _configure_class_object(clazz)
            clazz.attributes ||= []
            clazz.methods ||= []
            clazz.namespace = "#{clazz.namespace}.model"

            clazz.attributes.each do |attribute|
              if attribute.relationship
                clazz.add_method _create_fetcher(attribute)
              end

              clazz.add_method _create_getter(attribute)
              clazz.add_method _create_setter(attribute)
              clazz.add_method _create_builder(clazz.name, attribute)
            end

            attribute = clazz.find_collection_model_attribute
            if attribute.nil?
              clazz.add_interface 'IModel'
            else
              clazz.add_interface 'ICollectionModel<IModel>'
              clazz.add_method _create_get_size clazz
              clazz.add_method _create_get_elements attribute
            end
          end

          def _create_getter(attribute)
            MethodMeta.new do |method|
              @logger.debug "Create getter to attribute #{attribute.name}"

              method.visibility = 'public'
              method.return_type = attribute.type
              method.generic_return_type = up_first_letter attribute.generic_type
              method.name = "get#{attribute.name[0].upcase}#{attribute.name[1, (attribute.name.size - 1)]}"
              method.body = "return this.#{attribute.name};"
            end
          end

          def _create_setter(attribute)
            MethodMeta.new do |method|
              @logger.debug "Create setter to attribute #{attribute.name}"

              method.visibility = 'public'
              method.return_type = 'void'
              method.name = "set#{attribute.name[0].upcase}#{attribute.name[1, (attribute.name.size - 1)]}"
              method.body = "this.#{attribute.name} = #{attribute.name};"
              method.add_parameter(AttributeMeta.new do |a|
                a.type = attribute.type
                a.generic_type = attribute.generic_type
                a.name = attribute.name
              end)
            end
          end

          def _create_builder(class_name, attribute)
            MethodMeta.new do |method|
              @logger.debug "Create builder accessor to attribute #{attribute.name}"

              method.visibility = 'public'
              method.return_type = class_name
              method.name = "with#{attribute.name[0].upcase}#{attribute.name[1, (attribute.name.size - 1)]}"
              method.body = "this.#{attribute.name} = #{attribute.name};\nreturn this;"
              method.add_parameter(AttributeMeta.new do |a|
                a.type = attribute.type
                a.generic_type = attribute.generic_type
                a.name = attribute.name
              end)
            end
          end

          def _create_fetcher(attribute)
            MethodMeta.new do |method|
              @logger.debug "Create fetcher to relationship attribute #{attribute.name}"

              method.visibility = 'public'
              method.return_type = attribute.type
              method.generic_return_type = up_first_letter attribute.generic_type
              method.name = "fetch#{up_first_letter attribute.name}"
              method.body = 'throw new RuntimeException("Method not implemented.");'
            end
          end

          def _create_get_size(clazz)
            size = clazz.attributes.select { |a| a.name == 'size' }.first

            MethodMeta.new do |method|
              @logger.debug "Create method implementation to getSize()"
              @logger.warn "Could not find size attribute at #{clazz.name} class." if size.nil?

              method.visibility = 'public'
              method.return_type = 'integer'
              method.name = 'getSize'
              method.body = ((size.nil?) ? 'throw new RuntimeException("No such attribute \"size\" found.");' : "return this.size;")
            end
          end

          def _create_get_elements(attribute)
            MethodMeta.new do |method|
              @logger.debug "Create method implementation to getElements()"

              method.visibility = 'public'
              method.return_type = attribute.type
              method.generic_return_type = up_first_letter attribute.generic_type
              method.name = 'getElements'
              method.body = "return this.#{attribute.name};"
            end
          end

        end
      end
    end
  end
end