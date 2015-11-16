require 'rake/testtask'

# Excute unit tests
Rake::TestTask.new do |tester|
  puts 'Define environment to "test"'
  ENV['ENVIRONMENT'] = 'test'
  
  test_dir = "#{Dir.pwd}/test/unit/**/*.rb"
  puts "Loading tests from #{test_dir}"
  test_files = Dir.glob(test_dir).map {|file| file }
  puts

  tester.name = 'test:unit'
  tester.libs << "test"
  tester.test_files = test_files
  tester.verbose = true
end

namespace :gem do
  
  desc 'Build project.'
  task :build do
    Rake::Task['test:unit'].execute
    puts `gem build raml-poliglota.gemspec`
  end

  desc 'Install project.'
  task :install do
    Rake::Task['test:unit'].execute
    
    puts `gem build raml-poliglota.gemspec`
    version = ''
    `ls | grep raml-poliglota-`.to_s.split("\n").each do |f|
      version = f.sub('raml-poliglota-', '').sub('.gem', '')
    end
    puts `gem install raml-poliglota-#{version}.gem`
  end

end