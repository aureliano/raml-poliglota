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
        value.split("_").each { |s| s.capitalize! }.join("")
      end

    end
  end
end