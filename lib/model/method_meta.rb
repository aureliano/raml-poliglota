module RamlPoliglota
  module Model

    class MethodMeta

      def initialize
        yield self if block_given?
      end

      attr_accessor :name, :return_type, :generic_return_type, :visibility, :static, :final, :parameters, :body, :is_abstract

      def ==(obj)
        return false if (obj.nil? || !obj.instance_of?(MethodMeta))
        return (@name == obj.name && @parameters == obj.parameters)
      end

      def has_parameters?
        return !(@parameters.nil? || parameters.empty?)
      end

      def add_parameter(parameter)
        @parameters ||= []
        @parameters << parameter
      end

      def is_abstract?
        ((@is_abstract.nil?) ? false : is_abstract)
      end

    end

  end
end