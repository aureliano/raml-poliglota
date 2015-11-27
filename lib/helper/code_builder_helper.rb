require File.expand_path '../string_helper.rb', __FILE__

module RamlPoliglota
  module Helper
    module CodeBuilder

      include RamlPoliglota::Helper::Text

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

    end
  end
end