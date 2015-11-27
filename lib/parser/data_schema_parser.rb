module RamlPoliglota
  module Parser

    class DataSchemaParser

      include RamlPoliglota::Model
      include RamlPoliglota::Helper::String

      def initialize
        yield self if block_given?
      end

      attr_accessor :namespace, :entity_name, :data_schema, :language

      def parse
        raise "Entity name not provided." if string_empty? @entity_name
        raise "Data schema not provided." if string_empty? @data_schema
        raise "Programming language not provided." if @language.nil?
        
        hash = JSON.parse @data_schema

        clazz = ClassMeta.new do |c|
          c.namespace = @namespace
          c.name = send("to_#{@language.case}_case", @entity_name)
          c.documentation = hash['description']

          raise "Data schema '#{@entity_name}' doesn't have the 'properties' hash defined." if hash['properties'].nil?
          raise "The data schema #{@entity_name}'s attribute 'properties' must be of type Hash." unless hash['properties'].instance_of? Hash
          
          c.attributes ||= []
          _add_properties hash, c
          _add_relationship hash, c
        end

        hash['language'] = @language
        hash['class'] = clazz

        hash
      end

      private
      def _add_properties(hash, c)
        hash['properties'].each do |key, value|
          c.add_attribute(AttributeMeta.new do |a|
            a.name = key
            a.type = value['type']
            a.visibility = 'private'
            
            unless value['items'].nil?
              a.generic_type = value['items']['$ref']
              c.collection_model_key = a.name
            end
          end)
        end
      end

      def _add_relationship(hash, c)
        unless hash['$relationship'].nil?
          hash['$relationship'].each do |key, value|
            c.add_attribute(AttributeMeta.new do |a|
              if value['type'] == '$single'
                a.type = value['schema']
              elsif value['type'] == '$collection'
                a.type = 'array'
                a.generic_type = value['schema']
              else
                raise "Unsupported relationship type #{value['type']}. Expected one of [$single, $collection]"
              end

              a.name = key
              a.visibility = 'private'
              a.relationship = true
            end)
          end
        end
      end

    end
  end
end