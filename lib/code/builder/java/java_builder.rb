require File.expand_path '../../code_builder.rb', __FILE__

module RamlPoliglota
  module Code
    module Builder
      module Java

        class JavaBuilder < CodeBuilder

          include Helper::String

          def initialize
            @logger = AppLogger.create_logger self
          end

          def build_imodel(namespace)
            clazz = ClassMeta.new do |c|
              c.namespace = namespace
              c.is_interface = true
              c.name = 'IModel'
              c.documentation = 'Define a type to API data schema models.'
            end

            JavaInterfaceModelBuilder.new.build clazz
          end

          def build_icollection_model(namespace)
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

            JavaInterfaceCollectionModelBuilder.new.build clazz
          end

          def build_model(hash)
            return if hash.nil?

            clazz = hash['class']
            clazz.attributes.each do |attribute|
              if attribute.relationship
                clazz.add_method _create_fetcher(attribute)
              end

              clazz.add_method _create_getter(attribute)
              clazz.add_method _create_setter(attribute)
              clazz.add_method _create_builder(clazz.name, attribute)
            end

            clazz.attributes ||= []
            clazz.methods ||= []

            attribute = clazz.find_collection_model_attribute
            if attribute.nil?
              clazz.add_interface 'IModel'
            else
              clazz.add_interface 'ICollectionModel'
              clazz.add_method _create_get_size clazz
              clazz.add_method _create_get_elements attribute
            end

            JavaModelBuilder.new.build clazz
          end

          private
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
              @logger.warn "Could not find size attribute to use on implementation of getSize method." if size.nil?

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