module RamlPoliglota
  module Helper
    module String

      def string_empty?(value)
        unless value.nil?
          raise "#{value} (#{value.class}) is not a String." if value.instance_of?(String)
        end
        
        (value.nil? || value.empty?)
      end

      def up_first_letter(value)
        return if value.nil?
        "#{value[0].upcase}#{value[1, (value.size - 1)]}"
      end

      def to_camel_case(value)
        text = value.split '_'
        if text.size == 1
          return ((/^[a-z]/.match(value)) ? value.capitalize : value)
        end

        text.each { |s| s.capitalize! }.join("")
      end

      def to_snake_case(value)
        text = value.dup
        value.scan(/[A-Z]/).each { |v| text.sub! v, "_#{v.downcase}" }
        text.sub(/^_/, '').sub(/_{2,}/, '_').sub(/^_/, '').sub(/_$/, '').downcase
      end

    end
  end
end