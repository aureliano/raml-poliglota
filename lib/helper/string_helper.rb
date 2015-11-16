module RamlPoliglota
  module Helper

    class StringHelper

      def self.empty?(value)
        unless value.nil?
          raise "#{value} (#{value.class}) is not a String." unless value.instance_of? String
        end
        
        (value.nil? || value.empty?)
      end

      def self.to_camel_case(value)
        text = value.split '_'
        if text.size == 1
          return ((/^[a-z]/.match(value)) ? value.capitalize : value)
        end

        text.each { |s| s.capitalize! }.join("")
      end

      def self.to_snake_case(value)
        text = value.dup
        value.scan(/[A-Z]/).each { |v| text.sub! v, "_#{v.downcase}" }
        text.sub(/^_/, '').sub(/_{2,}/, '_').sub(/^_/, '').sub(/_$/, '').downcase
      end

    end
  end
end