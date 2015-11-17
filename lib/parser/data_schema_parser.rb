module RamlPoliglota
  module Parser

    class DataSchemaParser

      include RamlPoliglota::Helper

      def initialize
        yield self if block_given?
      end

      attr_accessor :namespace, :entity_name, :data_schema, :language

      def parse
        raise "Entity name not provided." if StringHelper.empty? @entity_name
        raise "Data schema not provided." if StringHelper.empty? @data_schema
        raise "Programming language not provided." if @language.nil?
        
        hash = JSON.parse @data_schema
        hash['entity_name'] = StringHelper.send("to_#{@language.case}_case", @entity_name)
        hash['namespace'] = @namespace
        hash['language'] = @language

        hash
      end

    end
  end
end