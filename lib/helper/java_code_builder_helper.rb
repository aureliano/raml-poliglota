module RamlPoliglota
  module Helper
    module JavaCodeBuilder

      include CodeBuilder

      def write_java_attribute(attribute)
        text = attribute.visibility.dup
        text << " static" if attribute.static == true
        text << " final" if attribute.final == true

        type = js_to_java_type attribute.type
        type = "#{type}<#{js_to_java_type attribute.generic_type}>" unless attribute.generic_type.nil?

        init = " = #{attribute.init_value}" unless attribute.init_value.nil?

        write_code("#{text} #{type} #{attribute.name}#{init};", 1)
      end

      def write_java_method(method)
        text = method.visibility.dup
        if method.is_abstract?
          text << ' abstract'
        else
          text << " static" if method.static == true
          text << " final" if method.final == true
        end

        type = ((method.return_type == 'void') ? 'void' :  js_to_java_type(method.return_type))
        type = "#{type}<#{js_to_java_type method.generic_return_type}>" unless method.generic_return_type.nil?

        text = write_code("#{text} #{type} #{method.name}(", 1)

        unless method.parameters.nil?
          params = method.parameters.collect do |p|
            type = js_to_java_type p.type
            type = "#{type}<#{js_to_java_type p.generic_type}>" unless p.generic_type.nil?
            "#{type} #{p.name}"
          end.join(", ")
          text << write_code(params, 0)
        end

        if method.is_abstract?
          return text << ');'
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

      def append_package(clazz, target)
        return if string_empty? clazz.namespace
        target << write_code("package #{clazz.namespace};\n\n", 0)
      end

      def append_javadoc(clazz, target)
        text = []
        text << "/**"
        text << " * Generated by RAML Poliglota."
        text << " *"
        text << " * #{clazz.documentation}"
        text << " */"

        target << write_code(text, 0)
        target << "\n"
      end

      def append_class_definition(clazz, target)
        definition = ((clazz.is_interface?) ? 'interface' : 'class')
        generify = "<#{clazz.generics}>" unless clazz.generics.nil?

        target << write_code("public #{definition} #{clazz.name}#{generify} {", 0)
        target << "\n\n"
      end

      def append_attributes(clazz, target)
        return if clazz.attributes.empty?
        target << clazz.attributes.collect do |attribute|
          "#{write_java_attribute(attribute)}"
        end.join("\n")
        target << "\n\n"
      end

      def append_methods(clazz, target)
        return if clazz.methods.empty?
        target << clazz.methods.collect do |method|
          write_java_method(method)
        end.join("\n\n")
        target << "\n"
      end

    end
  end
end