require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "railslove_deploy"
    s.summary = "The Railslove Deploy recipes"
    s.email = "michael@railslove.com"
    s.homepage = "http://github.com/bumi/railslove_deploy"
    s.description = "TODO"
    s.authors = ["Michael Bumann"]
    s.executables = ["gwify"]
    s.files = FileList["*.rb","bin/*", "lib/**/*", "test/**/*"]
    s.add_dependency("capistrano", ">= 2.5")
    s.add_dependency("sprinkle", ">= 0.1.9")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'railslove_deploy'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :rcov
