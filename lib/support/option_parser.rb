module RamlPoliglota
  module Support

    include RamlPoliglota::Model

    def command_line_options
      command = Execution.new

      opts = OptionParser.new do |opts|
        opts.banner = "RamlPoliglota: an utility for generating multi-language client applications to consume REST services."
        opts.define_head "Usage: raml-poliglota [path] [options]"
        opts.separator ""
        opts.separator "Examples:"
        opts.separator " raml-poliglota /path/to/raml/file.raml"
        opts.separator " raml-poliglota /path/to/raml/file.raml -o /path/to/save/generated/sources"
        opts.separator " raml-poliglota /path/to/raml/file.raml -o /path/to/save/generated/sources -l java"
        opts.separator ""
        opts.separator "Options:"

        opts.on('-o', "--output [path]", String, 'Path where generated files will be saved.') do |output|
          command.output = output
        end

        opts.on('-l', "--language [language]", String, 'Target programming language.') do |language|
          command.language = language
        end

        opts.on('-n', "--namespace [namespace]", String, 'The base source code namespace (package, module etc).') do |namespace|
          command.namespace = namespace
        end

        opts.on("--logger [level]", String, 'The logger level [debug, info, warn, error].') do |level|
          command.logger_level = level
        end

        opts.on_tail("-s", "--sources", "Show supported programming languages generation.") do
          puts "Supported programming languages: #{SUPPORTED_PROGRAMMING_LANGUAGES.join ', '}"
          exit
        end

        opts.on_tail("-h", "--help", "Show this message.") do
          puts opts
          exit
        end

        opts.on_tail("-v", "--version", "Show version.") do
          puts "raml-poliglota #{RELEASE_VERSION}"
          exit
        end
      end
      
      begin
        opts.parse!

        mandatory = [:output, :language]
        missing = mandatory.select{ |param| command.send(param).nil? }
        unless missing.empty?
          puts " * Missing option: #{missing}\n\n"
          puts opts
          exit
        end
        
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