require File.expand_path '../../code_builder.rb', __FILE__

module RamlPoliglota
  module Code
    module Builder
      module Java

        class JavaBuilder < CodeBuilder

          def initialize
            @logger = AppLogger.create_logger self
          end

          def build_model(clazz)
            return if clazz.nil?
            JavaModelBuilder.new.build clazz
          end
          
        end
      
      end
    end
  end
end