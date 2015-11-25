module RamlPoliglota
  module Helper
    module JavaCodeBuilder

      include CodeBuilder

      def write_java_attribute(attribute)
        type = js_to_java_type attribute.type
        type = "#{type}<#{js_to_java_type attribute.generic_type}>" unless attribute.generic_type.nil?
        write_code("#{attribute.visibility} #{type} #{attribute.name};", 1)
      end

      def write_java_method(method)
        type = ((method.return_type == 'void') ? 'void' :  js_to_java_type(method.return_type))
        type = "#{type}<#{js_to_java_type method.generic_return_type}>" unless method.generic_return_type.nil?

        text = write_code("#{method.visibility} #{type} #{method.name}(", 1)

        unless method.parameters.nil?
          params = method.parameters.collect do |p|
            type = js_to_java_type p.type
            "#{type} #{p.name}"
          end.join(", ")
          text << write_code(params, 0)
        end

        text << ") {\n"
        text << write_code(method.body.to_s.split("\n"), 2)
        text << "\n"
        text << (write_code "}", 1)
      end

      def js_to_java_type(js_type)
        raise "Could not parse empty string to Java type." if string_empty? js_type

        case js_type.downcase
          when 'string' then 'String'
          when 'number' then 'Double'
          when 'integer' then 'Integer'
          when 'boolean' then 'Boolean'
          when 'value' then 'Object'
          when 'array' then 'java.util.List'
          when 'object' then 'Object'
          else "#{js_type[0].capitalize}#{js_type[1, (js_type.size - 1)]}"
        end
      end

    end
  end
end