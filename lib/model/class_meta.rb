module RamlPoliglota
  module Model

    class ClassMeta

      def initialize
        yield self if block_given?
      end

      attr_accessor :namespace, :name, :documentation, :attributes, 
                    :methods, :interfaces, :is_interface, :generics,
                    :collection_model_key

      def ==(obj)
        return false if (obj.nil? || !obj.instance_of?(ClassMeta))
        return @name == obj.name
      end

      def add_attribute(attribute)
        @attributes ||= []
        @attributes << attribute
      end

      def add_method(method)
        @methods ||= []
        @methods << method
      end

      def add_interface(interface)
        @interfaces ||= []
        @interfaces << interface
      end

      def is_interface?
        ((@is_interface.nil?) ? false : is_interface)
      end

      def find_collection_model_attribute
        return if @attributes.nil?
        @attributes.select { |attribute| attribute.name == @collection_model_key }.first
      end

    end

  end
end