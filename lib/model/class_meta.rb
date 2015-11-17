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

    end

  end
end