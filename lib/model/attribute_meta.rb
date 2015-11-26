module RamlPoliglota
  module Model

    class AttributeMeta

      def initialize
        yield self if block_given?
      end

      attr_accessor :name, :type, :generic_type, :visibility, :static, :final, :init_value, :default_value, :relationship

      def ==(obj)
        return false if (obj.nil? || !obj.instance_of?(AttributeMeta))
        return @name == obj.name
      end

    end

  end
end