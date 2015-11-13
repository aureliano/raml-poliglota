module RamlPoliglota
  module Support

    include RamlPoliglota::Model

    def command_line_options
      command = Execution.new

      opts = OptionParser.new do |opts|
        opts.banner = "RamlPoliglota: an utility for generating multi-language client applications to consume REST services."
        opts.define_head "Usage: raml_poliglota [path] [options]"
        opts.separator ""
        opts.separator "Examples:"
        opts.separator " raml_poliglota /path/to/raml/file.raml"
        opts.separator " raml_poliglota /path/to/raml/file.raml -o /path/to/save/generated/sources"
        opts.separator " raml_poliglota /path/to/raml/file.raml -o /path/to/save/generated/sources -l java"
        opts.separator ""
        opts.separator "Options:"

        opts.on('-o', "--output [path]", String, 'Path where generated files will be saved.') do |output|
          command.output = output
        end

        opts.on('-l', "--language [language]", String, 'Target programming language.') do |language|
          command.language = language
        end

        opts.on_tail("-s", "--sources", "Show supported programming languages generation.") do
          puts "raml_poliglota #{RamlPoliglota::SUPPORTED_PROGRAMMING_LANGUAGES}"
          exit
        end

        opts.on_tail("-h", "--help", "Show this message.") do
          puts opts
          exit
        end

        opts.on_tail("-v", "--version", "Show version.") do
          puts "raml_poliglota #{RamlPoliglota::VERSION}"
          exit
        end
      end
      
      begin
        opts.parse!
        
        raml_path = ARGV.pop
        command.raml_path = raml_path
        
        command
      rescue Exception => ex      
        puts " - Error: #{ex}" unless ex.instance_of? SystemExit
        exit -1
      end
    end

  end
end