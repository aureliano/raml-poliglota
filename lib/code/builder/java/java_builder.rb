require File.expand_path '../../code_builder.rb', __FILE__

module RamlPoliglota
  module Code
    module Builder
      module Java

        class JavaBuilder < CodeBuilder

          include Helper::Text

          def build_model(hash)
            JavaModelBuilder.new.build hash
          end

          def build_imodel(namespace)
            JavaInterfaceModelBuilder.new.build namespace
          end

          def build_icollection_model(namespace)
            JavaInterfaceCollectionModelBuilder.new.build namespace
          end
          
        end
      
      end
    end
  end
end