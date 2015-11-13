$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'support/requires.rb'

RamlPoliglota::Support::SourceLoader.new.load_project_source_files

Gem::Specification.new do |s|
  s.name         = 'raml-poliglota'
  s.version      = RamlPoliglota::Support::RELEASE_VERSION
  s.date         = RamlPoliglota::Support::RELEASE_DATE
  s.summary      = "raml-poliglota-#{RamlPoliglota::Support::RELEASE_VERSION}: an utility for generating multi-language client applications to consume REST services."
  s.description  = "A gem for generating multi-language client applications to consume REST services."
  s.authors      = ["Aurealino"]
  s.email        = 'aureliano.franca@hotmail.com'
  s.homepage     = 'https://github.com/aureliano/raml-poliglota'
  s.license      = 'MIT'
  s.platform     = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.9.3"
  
  s.files        = `git ls-files`.split("\n").reject {|path| path =~ /\.gitignore$/ }
  s.test_files   = `git ls-files -- test/*`.split("\n")
  s.executables  = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.rdoc_options = ["--charset=UTF-8"]
  
  s.add_runtime_dependency 'logging', '~> 1.8.2'
end