require 'rubygems'
gem 'rspec', '>= 1.1.4'
require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

desc 'Default: run unit tests.'
task :default => :spec

task :pre_commit => [:spec, 'coverage:verify']

desc 'Run all specs under spec/**/*_spec.rb'
Spec::Rake::SpecTask.new(:spec => 'coverage:clean') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ["-c", "--diff"]
  t.rcov = true
  t.rcov_opts = ["--include-file", "lib\/*\.rb", "--exclude", "spec\/"]
end

desc 'Generate documentation for the yaml_waml plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'YamlWaml'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :coverage do
  desc "Delete aggregate coverage data."
  task(:clean) { rm_f "coverage" }

  desc "verify coverage threshold via RCov"
  RCov::VerifyTask.new(:verify => :spec) do |t|
    t.threshold = 100.0 # Make sure you have rcov 0.7 or higher!
    t.index_html = 'coverage/index.html'
  end
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "yaml_waml"
    gem.summary = "'to_yaml' workaround for multibyte UTF-8 string."
    gem.description = "Plugin gem to workaround for fixing output result of 'to_yaml' method treats multibyte UTF-8 string(such as japanese) as binary. "
    gem.has_rdoc = false
    gem.email = "shintaro@kakutani.com"
    gem.homepage = "http://github.com/kakutani/yaml_waml"
    gem.authors = ["KAKUTANI Shintaro", "Akira Ikeda"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
