module RamlPoliglota
  module Model

    class ClassMeta

      def initialize
        yield self if block_given?
      end

      attr_accessor :namespace, :name, :documentation, :attributes, :methods, :interfaces, :is_interface, :generics

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

      def is_interface?
        ((@is_interface.nil?) ? false : is_interface)
      end

    end

  end
end