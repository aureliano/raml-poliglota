module RamlPoliglota
  module Model

    class ProgrammingLanguage

      def initialize
        yield self if block_given?
      end

      attr_accessor :name, :case

      def ==(obj)
        return false if (obj.nil? || !obj.instance_of?(ProgrammingLanguage))
        return @name == obj.name
      end

    end

  end
end