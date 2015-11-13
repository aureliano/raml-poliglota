require File.expand_path '../support/requires.rb', __FILE__

RamlPoliglota::Support::SourceLoader.new.load_project_source_files

include RamlPoliglota::Support

command = command_line_options