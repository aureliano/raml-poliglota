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

          next if hash['properties'].nil?
          
          hash['properties'].each do |key, value|
            c.add_attribute(AttributeMeta.new do |a|
              a.name = key
              a.type = value['type']
              a.visibility = 'private'
            end)
          end

          unless hash['$linkedData'].nil?
            hash['$linkedData'].each do |key, value|
              c.add_method(MethodMeta.new do |m|
                entity = up_first_letter key
                m.visibility = 'public'
                m.name = "fetch#{entity}"
                m.return_type = entity
                m.body = 'throw new RuntimeException("Method not implemented.");'
              end)
            end
          end
        end

        hash['language'] = @language
        hash['class'] = clazz

        hash
      end

    end
  end
end