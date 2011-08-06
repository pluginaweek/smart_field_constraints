require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run all tests.'
task :default => :test

desc "Test smart_field_constraints."
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.test_files = Dir['test/**/*_test.rb']
  t.verbose = true
end

begin
  require 'rcov/rcovtask'
  namespace :test do
    desc "Test smart_field_constraints with Rcov."
    Rcov::RcovTask.new(:rcov) do |t|
      t.libs << 'lib'
      t.test_files = Dir['test/**/*_test.rb']
      t.rcov_opts << '--exclude="^(?!lib/)"'
      t.verbose = true
    end
  end
rescue LoadError
end

desc "Generate documentation for smart_field_constraints."
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'smart_field_constraints'
  rdoc.options << '--line-numbers' << '--inline-source' << '--main=README.rdoc'
  rdoc.rdoc_files.include('README.rdoc', 'CHANGELOG.rdoc', 'LICENSE', 'lib/**/*.rb')
end
