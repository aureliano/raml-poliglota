module RamlPoliglota
  module Helper
    module CodeBuilder

      include String

      TAB_SIZE = 2

      def write_tabulation(tabs)
        tabs.times.collect { ' ' * TAB_SIZE }.join
      end

      def write_code(lines, tab_size)
        ((lines.instance_of? Array) ? write_array(lines, tab_size) : write_string(lines.to_s, tab_size))
      end

      def write_string(text, tab_size)
        "#{write_tabulation tab_size}#{text}"
      end

      def write_array(lines, tab_size)
        lines.collect do |line|
          "#{write_tabulation(tab_size)}#{line}"
        end.join("\n")
      end

      def write_java_attribute(attribute)
        write_code("#{attribute.visibility} #{attribute.type} #{attribute.name};", 1)
      end

      def write_java_method(method)
        text = write_code("#{method.visibility} #{method.return_type} #{method.name}(", 1)

        unless method.parameters.nil?
          params = method.parameters.collect { |p| "#{p.type} #{p.name}" }.join(", ")
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