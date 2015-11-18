module RamlPoliglota
  module Model

    class ClassMeta

      def initialize
        yield self if block_given?
      end

      attr_accessor :namespace, :name, :documentation, :attributes, :methods, :interfaces

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

    end

  end
end