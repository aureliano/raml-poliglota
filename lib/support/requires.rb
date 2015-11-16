require 'logging'
require 'optparse'
require 'raml_parser'

module RamlPoliglota
  module Support

    class SourceLoader

      def initialize
        @ignorable_source_files = [File.join('support', 'requires.rb'), File.join('raml_poliglota.rb')]
        @dir_order = ['configuration', 'model', 'support', 'helper', 'validation']
        @lib_dir = File.dirname(__FILE__).sub /\/support$/, ''
      end

      def load_project_source_files
        @dir_order.each do |dir|
          Dir[File.join(@lib_dir, dir, '*.rb')].each {|source_file| _require_source_file source_file }
        end
      end

      private
      def _require_source_file(source_file)
        found = @ignorable_source_files.select {|file| source_file.end_with? file }
        return unless found.empty?

        require source_file
      end
    end

  end
end